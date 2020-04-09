"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
function showQueryInputBox(dbPath) {
    const options = {
        placeHolder: `Your query here (database: ${dbPath})`
    };
    return vscode_1.window.showInputBox(options);
}
exports.showQueryInputBox = showQueryInputBox;
//# sourceMappingURL=inputbox.js.map