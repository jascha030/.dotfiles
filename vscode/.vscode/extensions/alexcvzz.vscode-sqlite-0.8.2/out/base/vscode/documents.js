"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const util_1 = require("util");
const arrays_1 = require("../common/arrays");
const strings_1 = require("../common/strings");
function createTextDocument(language, content, cursorPos = new vscode_1.Position(0, 0), show = false) {
    return vscode_1.workspace.openTextDocument({ language: language, content: content }).then(document => {
        if (show) {
            vscode_1.window.showTextDocument(document, vscode_1.ViewColumn.One).then(editor => {
                editor.selection = new vscode_1.Selection(cursorPos, cursorPos);
            });
        }
        return Promise.resolve(document);
    });
}
exports.createTextDocument = createTextDocument;
function getActiveTextDocument(language) {
    let editor = vscode_1.window.activeTextEditor;
    if (!editor)
        return undefined;
    if (!language)
        return editor.document;
    let languages = strings_1.normalizeString(util_1.isArray(language) ? language : [language]);
    let documentLang = strings_1.normalizeString(editor.document.languageId);
    if (arrays_1.includes(languages, documentLang))
        return editor.document;
    else
        return undefined;
}
exports.getActiveTextDocument = getActiveTextDocument;
//# sourceMappingURL=documents.js.map