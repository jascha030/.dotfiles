"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
function createSqlDocument(content, cursorPos, show) {
    let sqliteDocContent = "-- SQLite\n" + content;
    cursorPos = cursorPos.translate(1);
    return vscode_1.workspace.openTextDocument({ language: 'sqlite', content: sqliteDocContent }).then(sqlDocument => {
        if (show) {
            vscode_1.window.showTextDocument(sqlDocument, vscode_1.ViewColumn.One).then(editor => {
                editor.selection = new vscode_1.Selection(cursorPos, cursorPos);
            });
        }
        return Promise.resolve(sqlDocument);
    });
}
exports.createSqlDocument = createSqlDocument;
function getEditorSqlDocument() {
    let editor = vscode_1.window.activeTextEditor;
    if (editor) {
        return editor.document.languageId === 'sql' || editor.document.languageId === 'sqlite' ? editor.document : undefined;
    }
    else {
        return undefined;
    }
}
exports.getEditorSqlDocument = getEditorSqlDocument;
function getEditorSelection() {
    let selection = vscode_1.window.activeTextEditor ? vscode_1.window.activeTextEditor.selection : undefined;
    // selection = selection && selection.isEmpty? undefined : selection;
    return selection;
}
exports.getEditorSelection = getEditorSelection;
//# sourceMappingURL=workspace.js.map