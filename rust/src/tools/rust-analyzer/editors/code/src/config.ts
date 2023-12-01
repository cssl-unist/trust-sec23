import * as vscode from 'vscode';
import { log } from "./util";

export type UpdatesChannel = "stable" | "nightly";

export const NIGHTLY_TAG = "nightly";

export type RunnableEnvCfg = undefined | Record<string, string> | { mask?: string; env: Record<string, string> }[];

export class Config {
    readonly extensionId = "matklad.rust-analyzer";

    readonly rootSection = "rust-analyzer";
    private readonly requiresReloadOpts = [
        "serverPath",
        "cargo",
        "procMacro",
        "files",
        "highlighting",
        "updates.channel",
        "lens", // works as lens.*
        "hoverActions", // works as hoverActions.*
    ]
        .map(opt => `${this.rootSection}.${opt}`);

    readonly package: {
        version: string;
        releaseTag: string | null;
        enableProposedApi: boolean | undefined;
    } = vscode.extensions.getExtension(this.extensionId)!.packageJSON;

    readonly globalStoragePath: string;

    constructor(ctx: vscode.ExtensionContext) {
        this.globalStoragePath = ctx.globalStoragePath;
        vscode.workspace.onDidChangeConfiguration(this.onDidChangeConfiguration, this, ctx.subscriptions);
        this.refreshLogging();
    }

    private refreshLogging() {
        log.setEnabled(this.traceExtension);
        log.info("Extension version:", this.package.version);

        const cfg = Object.entries(this.cfg).filter(([_, val]) => !(val instanceof Function));
        log.info("Using configuration", Object.fromEntries(cfg));
    }

    private async onDidChangeConfiguration(event: vscode.ConfigurationChangeEvent) {
        this.refreshLogging();

        const requiresReloadOpt = this.requiresReloadOpts.find(
            opt => event.affectsConfiguration(opt)
        );

        if (!requiresReloadOpt) return;

        const userResponse = await vscode.window.showInformationMessage(
            `Changing "${requiresReloadOpt}" requires a reload`,
            "Reload now"
        );

        if (userResponse === "Reload now") {
            await vscode.commands.executeCommand("workbench.action.reloadWindow");
        }
    }

    // We don't do runtime config validation here for simplicity. More on stackoverflow:
    // https://stackoverflow.com/questions/60135780/what-is-the-best-way-to-type-check-the-configuration-for-vscode-extension

    private get cfg(): vscode.WorkspaceConfiguration {
        return vscode.workspace.getConfiguration(this.rootSection);
    }

    /**
     * Beware that postfix `!` operator erases both `null` and `undefined`.
     * This is why the following doesn't work as expected:
     *
     * ```ts
     * const nullableNum = vscode
     *  .workspace
     *  .getConfiguration
     *  .getConfiguration("rust-analyer")
     *  .get<number | null>(path)!;
     *
     * // What happens is that type of `nullableNum` is `number` but not `null | number`:
     * const fullFledgedNum: number = nullableNum;
     * ```
     * So this getter handles this quirk by not requiring the caller to use postfix `!`
     */
    private get<T>(path: string): T {
        return this.cfg.get<T>(path)!;
    }

    get serverPath() { return this.get<null | string>("serverPath"); }
    get channel() { return this.get<UpdatesChannel>("updates.channel"); }
    get askBeforeDownload() { return this.get<boolean>("updates.askBeforeDownload"); }
    get traceExtension() { return this.get<boolean>("trace.extension"); }

    get inlayHints() {
        return {
            enable: this.get<boolean>("inlayHints.enable"),
            typeHints: this.get<boolean>("inlayHints.typeHints"),
            parameterHints: this.get<boolean>("inlayHints.parameterHints"),
            chainingHints: this.get<boolean>("inlayHints.chainingHints"),
            maxLength: this.get<null | number>("inlayHints.maxLength"),
        };
    }

    get checkOnSave() {
        return {
            command: this.get<string>("checkOnSave.command"),
        };
    }

    get cargoRunner() {
        return this.get<string | undefined>("cargoRunner");
    }

    get runnableEnv() {
        return this.get<RunnableEnvCfg>("runnableEnv");
    }

    get debug() {
        // "/rustc/<id>" used by suggestions only.
        const { ["/rustc/<id>"]: _, ...sourceFileMap } = this.get<Record<string, string>>("debug.sourceFileMap");

        return {
            engine: this.get<string>("debug.engine"),
            engineSettings: this.get<object>("debug.engineSettings"),
            openDebugPane: this.get<boolean>("debug.openDebugPane"),
            sourceFileMap: sourceFileMap
        };
    }

    get lens() {
        return {
            enable: this.get<boolean>("lens.enable"),
            run: this.get<boolean>("lens.run"),
            debug: this.get<boolean>("lens.debug"),
            implementations: this.get<boolean>("lens.implementations"),
        };
    }

    get hoverActions() {
        return {
            enable: this.get<boolean>("hoverActions.enable"),
            implementations: this.get<boolean>("hoverActions.implementations"),
            run: this.get<boolean>("hoverActions.run"),
            debug: this.get<boolean>("hoverActions.debug"),
            gotoTypeDef: this.get<boolean>("hoverActions.gotoTypeDef"),
        };
    }
}
