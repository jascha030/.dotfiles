"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
function showErrorMessage(message, ...actions) {
    let items = actions.map(action => action.title);
    vscode_1.window.showErrorMessage(message, ...items).then(item => {
        actions.forEach(action => {
            if (action.title === item) {
                vscode_1.commands.executeCommand(action.command, action.args);
            }
        });
    });
}
exports.showErrorMessage = showErrorMessage;
//# sourceMappingURL=errorMessage.js.map