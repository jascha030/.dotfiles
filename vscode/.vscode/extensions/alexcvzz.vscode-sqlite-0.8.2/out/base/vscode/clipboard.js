"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const clipboardy = require("clipboardy");
const vscode_1 = require("vscode");
/**
 * Copy a message to clipboard and show a status bar message to confirm the message was copied.
 * @param text The message to copy to clipboard
 */
function copyToClipboard(text) {
    return clipboardy.write(text).then(() => {
        return vscode_1.window.setStatusBarMessage(`Copied '${text}' to clipboard.`, 2000);
    });
}
exports.copyToClipboard = copyToClipboard;
/**
 * Read a message from the clipboard.
 */
function readFromClipboard() {
    return clipboardy.read();
}
exports.readFromClipboard = readFromClipboard;
//# sourceMappingURL=clipboard.js.map