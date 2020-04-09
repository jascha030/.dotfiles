"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
class Global {
    static get activeConnection() {
        return Global._activeConnection;
    }
    static set activeConnection(newActiveConnection) {
        this._activeConnection = newActiveConnection;
        Global.updateStatusBarItems(newActiveConnection);
    }
    static updateStatusBarItems(activeConnection) {
        if (Global.mysqlStatusBarItem) {
            Global.mysqlStatusBarItem.text = Global.getStatusBarItemText(activeConnection);
        }
        else {
            Global.mysqlStatusBarItem = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left);
            Global.mysqlStatusBarItem.text = Global.getStatusBarItemText(activeConnection);
            Global.mysqlStatusBarItem.show();
        }
    }
    static getStatusBarItemText(activeConnection) {
        return `$(server) ${activeConnection.host}` + (activeConnection.database ? ` $(database) ${activeConnection.database}` : "");
    }
}
Global.keytar = getCoreNodeModule(`keytar`);
exports.Global = Global;
/**
 * Returns a node module installed with VSCode, or null if it fails.
 */
function getCoreNodeModule(moduleName) {
    try {
        return require(`${vscode.env.appRoot}/node_modules.asar/${moduleName}`);
    }
    catch (err) { }
    try {
        return require(`${vscode.env.appRoot}/node_modules/${moduleName}`);
    }
    catch (err) { }
    return null;
}
//# sourceMappingURL=global.js.map