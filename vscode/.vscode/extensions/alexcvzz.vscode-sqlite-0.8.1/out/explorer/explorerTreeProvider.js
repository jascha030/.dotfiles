"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const treeItem_1 = require("./treeItem");
class ExplorerTreeProvider {
    constructor() {
        this._onDidChangeTreeData = new vscode_1.EventEmitter();
        this.onDidChangeTreeData = this._onDidChangeTreeData.event;
        this.databaseList = [];
    }
    refresh() {
        this._onDidChangeTreeData.fire();
    }
    addToTree(database) {
        let index = this.databaseList.findIndex(db => db.path === database.path);
        if (index < 0) {
            this.databaseList.push(database);
        }
        else {
            this.databaseList[index] = database;
        }
        this.refresh();
        return this.databaseList.length;
    }
    removeFromTree(dbPath) {
        let index = this.databaseList.findIndex(db => db.path === dbPath);
        if (index > -1) {
            this.databaseList.splice(index, 1);
        }
        this.refresh();
        return this.databaseList.length;
    }
    getTreeItem(item) {
        if ('tables' in item) {
            // Database
            return new treeItem_1.DBItem(item.path);
        }
        else if ('columns' in item) {
            // Table
            return new treeItem_1.TableItem(item.name, item.type);
        }
        else {
            // Column
            return new treeItem_1.ColumnItem(item.name, item.type, item.notnull, item.pk, item.defVal);
        }
    }
    getDatabaseList() {
        return this.databaseList;
    }
    getChildren(item) {
        if (item) {
            if ('tables' in item) {
                // Database
                return item.tables;
            }
            else if ('columns' in item) {
                // Table
                return item.columns;
            }
            else {
                // Column
                return [];
            }
        }
        else {
            // Root
            return this.databaseList;
        }
    }
}
exports.ExplorerTreeProvider = ExplorerTreeProvider;
//# sourceMappingURL=explorerTreeProvider.js.map