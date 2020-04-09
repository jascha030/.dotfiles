"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const Transformations_1 = require("./Transformations");
class PHPFmtProvider {
    constructor(phpfmt) {
        this.phpfmt = phpfmt;
        this.widget = this.phpfmt.getWidget();
        this.documentSelector = [
            { language: 'php', scheme: 'file' },
            { language: 'php', scheme: 'untitled' }
        ];
    }
    onDidChangeConfiguration() {
        return vscode_1.workspace.onDidChangeConfiguration(() => {
            this.phpfmt.loadSettings();
        });
    }
    formatCommand() {
        return vscode_1.commands.registerTextEditorCommand('phpfmt.format', textEditor => {
            if (textEditor.document.languageId === 'php') {
                vscode_1.commands.executeCommand('editor.action.formatDocument');
            }
        });
    }
    listTransformationsCommand() {
        return vscode_1.commands.registerCommand('phpfmt.listTransformations', () => {
            const transformations = new Transformations_1.default(this.phpfmt.getConfig().php_bin);
            const transformationItems = transformations.getTransformations();
            const items = new Array();
            for (const item of transformationItems) {
                items.push({
                    label: item.key,
                    description: item.description
                });
            }
            vscode_1.window.showQuickPick(items).then(result => {
                if (typeof result !== 'undefined') {
                    const output = transformations.getExample({
                        key: result.label,
                        description: result.description
                    });
                    this.widget.addToOutput(output).show();
                }
            });
        });
    }
    documentFormattingEditProvider() {
        return vscode_1.languages.registerDocumentFormattingEditProvider(this.documentSelector, {
            provideDocumentFormattingEdits: document => {
                return new Promise((resolve, reject) => {
                    const originalText = document.getText();
                    const lastLine = document.lineAt(document.lineCount - 1);
                    const range = new vscode_1.Range(new vscode_1.Position(0, 0), lastLine.range.end);
                    this.phpfmt
                        .format(originalText)
                        .then((text) => {
                        if (text !== originalText) {
                            resolve([new vscode_1.TextEdit(range, text)]);
                        }
                        else {
                            reject();
                        }
                    })
                        .catch(err => {
                        if (err instanceof Error) {
                            vscode_1.window.showErrorMessage(err.message);
                            this.widget.addToOutput(err.message);
                        }
                        reject();
                    });
                });
            }
        });
    }
    documentRangeFormattingEditProvider() {
        return vscode_1.languages.registerDocumentRangeFormattingEditProvider(this.documentSelector, {
            provideDocumentRangeFormattingEdits: (document, range) => {
                return new Promise((resolve, reject) => {
                    let originalText = document.getText(range);
                    if (originalText.replace(/\s+/g, '').length === 0) {
                        return reject();
                    }
                    let hasModified = false;
                    if (originalText.search(/^\s*<\?php/i) === -1) {
                        originalText = `<?php\n${originalText}`;
                        hasModified = true;
                    }
                    this.phpfmt
                        .format(originalText)
                        .then((text) => {
                        if (hasModified) {
                            text = text.replace(/^<\?php\r?\n/, '');
                        }
                        if (text !== originalText) {
                            resolve([new vscode_1.TextEdit(range, text)]);
                        }
                        else {
                            reject();
                        }
                    })
                        .catch(err => {
                        if (err instanceof Error) {
                            vscode_1.window.showErrorMessage(err.message);
                            this.widget.addToOutput(err.message);
                        }
                        reject();
                    });
                });
            }
        });
    }
    statusBarItem() {
        return [
            vscode_1.window.onDidChangeActiveTextEditor(editor => {
                if (typeof this.statusBarItem !== 'undefined') {
                    this.widget.toggleStatusBarItem(editor);
                }
            }),
            vscode_1.commands.registerCommand('phpfmt.openOutput', () => {
                this.widget.getOutputChannel().show();
            })
        ];
    }
}
exports.default = PHPFmtProvider;
//# sourceMappingURL=PHPFmtProvider.js.map