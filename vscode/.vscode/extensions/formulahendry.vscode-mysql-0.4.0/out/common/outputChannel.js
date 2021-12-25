"user strict";
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
class OutputChannel {
    static appendLine(value) {
        OutputChannel.outputChannel.show(true);
        OutputChannel.outputChannel.appendLine(value);
    }
}
OutputChannel.outputChannel = vscode.window.createOutputChannel("MySQL");
exports.OutputChannel = OutputChannel;
//# sourceMappingURL=outputChannel.js.map