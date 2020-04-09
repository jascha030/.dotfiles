"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const documentDatabaseBindings_1 = require("./documentDatabaseBindings");
const databaseStatusBarItem_1 = require("./databaseStatusBarItem");
class SqlWorkspace {
    constructor() {
        let subscriptions = [];
        this.documentDatabaseBindings = new documentDatabaseBindings_1.DocumentDatabaseBindings();
        this.databaseStatusBarItem = new databaseStatusBarItem_1.DatabaseStatusBarItem(this.documentDatabaseBindings);
        subscriptions.push(this.documentDatabaseBindings);
        subscriptions.push(this.databaseStatusBarItem);
        this.disposable = vscode_1.Disposable.from(...subscriptions);
    }
    bindDatabaseToDocument(databasePath, sqlDocument) {
        let success = this.documentDatabaseBindings.bind(sqlDocument, databasePath);
        if (success) {
            this.databaseStatusBarItem.update();
        }
        return success;
    }
    getDocumentDatabase(sqlDocument) {
        return this.documentDatabaseBindings.get(sqlDocument);
    }
    dispose() {
        this.disposable.dispose();
    }
}
exports.default = SqlWorkspace;
//# sourceMappingURL=index.js.map