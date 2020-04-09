"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const path_1 = require("path");
class DatabaseStatusBarItem {
    constructor(documentDatabase) {
        this.documentDatabase = documentDatabase;
        let subscriptions = [];
        this.statusBarItem = vscode_1.window.createStatusBarItem(vscode_1.StatusBarAlignment.Right, 100);
        this.statusBarItem.command = "sqlite.useDatabase";
        subscriptions.push(this.statusBarItem);
        subscriptions.push(vscode_1.window.onDidChangeActiveTextEditor(e => this.update()));
        subscriptions.push(vscode_1.window.onDidChangeTextEditorViewColumn(e => this.update()));
        subscriptions.push(vscode_1.workspace.onDidOpenTextDocument(e => this.update()));
        subscriptions.push(vscode_1.workspace.onDidCloseTextDocument(e => this.update()));
        this.disposable = vscode_1.Disposable.from(...subscriptions);
    }
    update() {
        let doc = vscode_1.window.activeTextEditor && (vscode_1.window.activeTextEditor.document.languageId === 'sql' || vscode_1.window.activeTextEditor.document.languageId === 'sqlite') ? vscode_1.window.activeTextEditor.document : undefined;
        if (doc) {
            let db = this.documentDatabase.get(doc);
            let dbPath;
            let dbName;
            if (db) {
                dbPath = db;
                dbName = path_1.basename(dbPath);
            }
            else {
                dbPath = 'No database';
                dbName = dbPath;
            }
            this.statusBarItem.tooltip = `SQLite: ${dbPath}`;
            this.statusBarItem.text = `SQLite: ${dbName}`;
            this.statusBarItem.show();
        }
        else {
            this.statusBarItem.hide();
        }
    }
    dispose() {
        this.disposable.dispose();
    }
}
exports.DatabaseStatusBarItem = DatabaseStatusBarItem;
//# sourceMappingURL=databaseStatusBarItem.js.map