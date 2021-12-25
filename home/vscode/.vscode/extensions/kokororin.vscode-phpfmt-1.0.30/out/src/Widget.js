"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
class Widget {
    static getInstance() {
        if (!this.instance) {
            this.instance = new Widget();
        }
        return this.instance;
    }
    constructor() {
        this.outputChannel = vscode_1.window.createOutputChannel('phpfmt');
        this.statusBarItem = vscode_1.window.createStatusBarItem(vscode_1.StatusBarAlignment.Right, -1);
        this.statusBarItem.text = 'phpfmt';
        this.statusBarItem.command = 'phpfmt.openOutput';
        this.toggleStatusBarItem(vscode_1.window.activeTextEditor);
    }
    toggleStatusBarItem(editor) {
        if (typeof editor === 'undefined') {
            return;
        }
        if (editor.document.languageId === 'php') {
            this.statusBarItem.show();
        }
        else {
            this.statusBarItem.hide();
        }
    }
    getOutputChannel() {
        return this.outputChannel;
    }
    addToOutput(message) {
        const title = new Date().toLocaleString();
        this.outputChannel.appendLine(title);
        this.outputChannel.appendLine('-'.repeat(title.length));
        this.outputChannel.appendLine(`${message}\n`);
        return this.outputChannel;
    }
}
exports.default = Widget;
//# sourceMappingURL=Widget.js.map