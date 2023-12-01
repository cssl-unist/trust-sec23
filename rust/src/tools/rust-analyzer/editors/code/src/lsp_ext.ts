/**
 * This file mirrors `crates/rust-analyzer/src/lsp_ext.rs` declarations.
 */

import * as lc from "vscode-languageclient";

export const analyzerStatus = new lc.RequestType<null, string, void>("rust-analyzer/analyzerStatus");
export const memoryUsage = new lc.RequestType<null, string, void>("rust-analyzer/memoryUsage");

export type Status = "loading" | "ready" | "invalid" | "needsReload";
export interface StatusParams {
    status: Status;
}
export const status = new lc.NotificationType<StatusParams>("rust-analyzer/status");

export const reloadWorkspace = new lc.RequestType<null, null, void>("rust-analyzer/reloadWorkspace");

export interface SyntaxTreeParams {
    textDocument: lc.TextDocumentIdentifier;
    range: lc.Range | null;
}
export const syntaxTree = new lc.RequestType<SyntaxTreeParams, string, void>("rust-analyzer/syntaxTree");


export interface ExpandMacroParams {
    textDocument: lc.TextDocumentIdentifier;
    position: lc.Position;
}
export interface ExpandedMacro {
    name: string;
    expansion: string;
}
export const expandMacro = new lc.RequestType<ExpandMacroParams, ExpandedMacro | null, void>("rust-analyzer/expandMacro");

export interface MatchingBraceParams {
    textDocument: lc.TextDocumentIdentifier;
    positions: lc.Position[];
}
export const matchingBrace = new lc.RequestType<MatchingBraceParams, lc.Position[], void>("experimental/matchingBrace");

export const parentModule = new lc.RequestType<lc.TextDocumentPositionParams, lc.LocationLink[], void>("experimental/parentModule");

export interface ResolveCodeActionParams {
    id: string;
    codeActionParams: lc.CodeActionParams;
}
export const resolveCodeAction = new lc.RequestType<ResolveCodeActionParams, lc.WorkspaceEdit, unknown>('experimental/resolveCodeAction');

export interface JoinLinesParams {
    textDocument: lc.TextDocumentIdentifier;
    ranges: lc.Range[];
}
export const joinLines = new lc.RequestType<JoinLinesParams, lc.TextEdit[], void>("experimental/joinLines");

export const onEnter = new lc.RequestType<lc.TextDocumentPositionParams, lc.TextEdit[], void>("experimental/onEnter");

export interface RunnablesParams {
    textDocument: lc.TextDocumentIdentifier;
    position: lc.Position | null;
}

export interface Runnable {
    label: string;
    location?: lc.LocationLink;
    kind: "cargo";
    args: {
        workspaceRoot?: string;
        cargoArgs: string[];
        executableArgs: string[];
        expectTest?: boolean;
    };
}
export const runnables = new lc.RequestType<RunnablesParams, Runnable[], void>("experimental/runnables");

export type InlayHint = InlayHint.TypeHint | InlayHint.ParamHint | InlayHint.ChainingHint;

export namespace InlayHint {
    export const enum Kind {
        TypeHint = "TypeHint",
        ParamHint = "ParameterHint",
        ChainingHint = "ChainingHint",
    }
    interface Common {
        range: lc.Range;
        label: string;
    }
    export type TypeHint = Common & { kind: Kind.TypeHint };
    export type ParamHint = Common & { kind: Kind.ParamHint };
    export type ChainingHint = Common & { kind: Kind.ChainingHint };
}
export interface InlayHintsParams {
    textDocument: lc.TextDocumentIdentifier;
}
export const inlayHints = new lc.RequestType<InlayHintsParams, InlayHint[], void>("rust-analyzer/inlayHints");

export interface SsrParams {
    query: string;
    parseOnly: boolean;
    textDocument: lc.TextDocumentIdentifier;
    position: lc.Position;
    selections: lc.Range[];
}
export const ssr = new lc.RequestType<SsrParams, lc.WorkspaceEdit, void>('experimental/ssr');

export interface CommandLink extends lc.Command {
    /**
     * A tooltip for the command, when represented in the UI.
     */
    tooltip?: string;
}

export interface CommandLinkGroup {
    title?: string;
    commands: CommandLink[];
}
