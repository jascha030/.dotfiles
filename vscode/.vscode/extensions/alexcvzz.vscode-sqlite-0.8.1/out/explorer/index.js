"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const explorerTreeProvider_1 = require("./explorerTreeProvider");
const constants_1 = require("../constants/constants");
class Explorer {
    constructor() {
        let subscriptions = [];
        this.explorerTreeProvider = new explorerTreeProvider_1.ExplorerTreeProvider();
        subscriptions.push(vscode_1.window.createTreeView(constants_1.Constants.sqliteExplorerViewId, { treeDataProvider: this.explorerTreeProvider }));
        this.disposable = vscode_1.Disposable.from(...subscriptions);
    }
    add(database) {
        let length = this.explorerTreeProvider.addToTree(database);
        if (length > 0)
            vscode_1.commands.executeCommand('setContext', 'sqlite.explorer.show', true);
    }
    remove(dbPath) {
        let length = this.explorerTreeProvider.removeFromTree(dbPath);
        if (length === 0) {
            // close the explorer with a slight delay (it looks better)
            setTimeout(() => {
                vscode_1.commands.executeCommand('setContext', 'sqlite.explorer.show', false);
            }, 100);
        }
    }
    list() {
        return this.explorerTreeProvider.getDatabaseList();
    }
    refresh() {
        this.explorerTreeProvider.refresh();
    }
    dispose() {
        this.disposable.dispose();
    }
}
exports.default = Explorer;
//# sourceMappingURL=index.js.map