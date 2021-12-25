"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
/**
 * Opens an input box to ask the user for input.
 *
 * Rejects if the input box was canceled (e.g. pressing ESC).
 * Otherwise the returned value will be the string typed by the user or an empty string if the user did not type anything
 * but dismissed the input box with OK.
 */
function showInputBox(hint) {
    const options = {
        placeHolder: hint
    };
    return vscode_1.window.showInputBox(options).then(input => {
        if (input === undefined) {
            return Promise.reject();
        }
        return input;
    });
}
exports.showInputBox = showInputBox;
//# sourceMappingURL=inputBox.js.map