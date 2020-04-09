"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const completions_1 = require("./completions");
const documenter_1 = require("./documenter");
/**
 * Run a set up when the function is activated
 *
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {
    ['php', 'hack'].forEach(lang => {
        if (lang == 'hack') {
            vscode.languages.setLanguageConfiguration(lang, {
                wordPattern: /(-?\d*\.\d\w*)|([^\-\`\~\!\@\#\%\^\&\*\(\)\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/g,
                onEnterRules: [
                    {
                        // e.g. /** | */
                        beforeText: /^\s*\/\*\*(?!\/)([^\*]|\*(?!\/))*$/,
                        afterText: /^\s*\*\/$/,
                        action: { indentAction: vscode.IndentAction.IndentOutdent, appendText: ' * ' }
                    }, {
                        // e.g. /** ...|
                        beforeText: /^\s*\/\*\*(?!\/)([^\*]|\*(?!\/))*$/,
                        action: { indentAction: vscode.IndentAction.None, appendText: ' * ' }
                    }, {
                        // e.g.  * ...|
                        beforeText: /^(\t|(\ \ ))*\ \*(\ ([^\*]|\*(?!\/))*)?$/,
                        action: { indentAction: vscode.IndentAction.None, appendText: '* ' }
                    }, {
                        // e.g.  */|
                        beforeText: /^(\t|(\ \ ))*\ \*\/\s*$/,
                        action: { indentAction: vscode.IndentAction.None, removeText: 1 }
                    }
                ]
            });
        }
        vscode.languages.registerCompletionItemProvider(lang, new completions_1.default(), '*', '@');
    });
    vscode.commands.registerTextEditorCommand('php-docblocker.trigger', (textEditor) => {
        textEditor.selection = new vscode.Selection(textEditor.selection.start, textEditor.selection.start);
        let range = new vscode.Range(textEditor.selection.start, textEditor.selection.end);
        let documenter = new documenter_1.default(range, textEditor);
        let snippet = documenter.autoDocument();
        textEditor.insertSnippet(snippet);
    });
}
exports.activate = activate;
/**
 * Shutdown method for the extension
 */
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map