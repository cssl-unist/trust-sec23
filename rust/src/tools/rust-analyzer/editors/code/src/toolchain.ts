import * as cp from 'child_process';
import * as os from 'os';
import * as path from 'path';
import * as fs from 'fs';
import * as readline from 'readline';
import { OutputChannel } from 'vscode';
import { log, memoize } from './util';

interface CompilationArtifact {
    fileName: string;
    name: string;
    kind: string;
    isTest: boolean;
}

export interface ArtifactSpec {
    cargoArgs: string[];
    filter?: (artifacts: CompilationArtifact[]) => CompilationArtifact[];
}

export class Cargo {
    constructor(readonly rootFolder: string, readonly output: OutputChannel) { }

    // Made public for testing purposes
    static artifactSpec(args: readonly string[]): ArtifactSpec {
        const cargoArgs = [...args, "--message-format=json"];

        // arguments for a runnable from the quick pick should be updated.
        // see crates\rust-analyzer\src\main_loop\handlers.rs, handle_code_lens
        switch (cargoArgs[0]) {
            case "run": cargoArgs[0] = "build"; break;
            case "test": {
                if (!cargoArgs.includes("--no-run")) {
                    cargoArgs.push("--no-run");
                }
                break;
            }
        }

        const result: ArtifactSpec = { cargoArgs: cargoArgs };
        if (cargoArgs[0] === "test") {
            // for instance, `crates\rust-analyzer\tests\heavy_tests\main.rs` tests
            // produce 2 artifacts: {"kind": "bin"} and {"kind": "test"}
            result.filter = (artifacts) => artifacts.filter(it => it.isTest);
        }

        return result;
    }

    private async getArtifacts(spec: ArtifactSpec): Promise<CompilationArtifact[]> {
        const artifacts: CompilationArtifact[] = [];

        try {
            await this.runCargo(spec.cargoArgs,
                message => {
                    if (message.reason === 'compiler-artifact' && message.executable) {
                        const isBinary = message.target.crate_types.includes('bin');
                        const isBuildScript = message.target.kind.includes('custom-build');
                        if ((isBinary && !isBuildScript) || message.profile.test) {
                            artifacts.push({
                                fileName: message.executable,
                                name: message.target.name,
                                kind: message.target.kind[0],
                                isTest: message.profile.test
                            });
                        }
                    } else if (message.reason === 'compiler-message') {
                        this.output.append(message.message.rendered);
                    }
                },
                stderr => this.output.append(stderr),
            );
        } catch (err) {
            this.output.show(true);
            throw new Error(`Cargo invocation has failed: ${err}`);
        }

        return spec.filter?.(artifacts) ?? artifacts;
    }

    async executableFromArgs(args: readonly string[]): Promise<string> {
        const artifacts = await this.getArtifacts(Cargo.artifactSpec(args));

        if (artifacts.length === 0) {
            throw new Error('No compilation artifacts');
        } else if (artifacts.length > 1) {
            throw new Error('Multiple compilation artifacts are not supported.');
        }

        return artifacts[0].fileName;
    }

    private runCargo(
        cargoArgs: string[],
        onStdoutJson: (obj: any) => void,
        onStderrString: (data: string) => void
    ): Promise<number> {
        return new Promise((resolve, reject) => {
            const cargo = cp.spawn(cargoPath(), cargoArgs, {
                stdio: ['ignore', 'pipe', 'pipe'],
                cwd: this.rootFolder
            });

            cargo.on('error', err => reject(new Error(`could not launch cargo: ${err}`)));

            cargo.stderr.on('data', chunk => onStderrString(chunk.toString()));

            const rl = readline.createInterface({ input: cargo.stdout });
            rl.on('line', line => {
                const message = JSON.parse(line);
                onStdoutJson(message);
            });

            cargo.on('exit', (exitCode, _) => {
                if (exitCode === 0)
                    resolve(exitCode);
                else
                    reject(new Error(`exit code: ${exitCode}.`));
            });
        });
    }
}

/** Mirrors `toolchain::cargo()` implementation */
export function cargoPath(): string {
    return getPathForExecutable("cargo");
}

/** Mirrors `toolchain::get_path_for_executable()` implementation */
export const getPathForExecutable = memoize(
    // We apply caching to decrease file-system interactions
    (executableName: "cargo" | "rustc" | "rustup"): string => {
        {
            const envVar = process.env[executableName.toUpperCase()];
            if (envVar) return envVar;
        }

        if (lookupInPath(executableName)) return executableName;

        try {
            // hmm, `os.homedir()` seems to be infallible
            // it is not mentioned in docs and cannot be infered by the type signature...
            const standardPath = path.join(os.homedir(), ".cargo", "bin", executableName);

            if (isFile(standardPath)) return standardPath;
        } catch (err) {
            log.error("Failed to read the fs info", err);
        }
        return executableName;
    }
);

function lookupInPath(exec: string): boolean {
    const paths = process.env.PATH ?? "";;

    const candidates = paths.split(path.delimiter).flatMap(dirInPath => {
        const candidate = path.join(dirInPath, exec);
        return os.type() === "Windows_NT"
            ? [candidate, `${candidate}.exe`]
            : [candidate];
    });

    return candidates.some(isFile);
}

function isFile(suspectPath: string): boolean {
    // It is not mentionned in docs, but `statSync()` throws an error when
    // the path doesn't exist
    try {
        return fs.statSync(suspectPath).isFile();
    } catch {
        return false;
    }
}
