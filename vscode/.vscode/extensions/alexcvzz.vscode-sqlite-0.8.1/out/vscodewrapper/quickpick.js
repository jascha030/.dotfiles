"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const path_1 = require("path");
var QuickPick;
(function (QuickPick) {
    class DatabaseItem {
        constructor(path, description) {
            this.path = path;
            this.label = path_1.basename(path);
            this.description = description ? description : path;
        }
    }
    QuickPick.DatabaseItem = DatabaseItem;
    class FileDialogItem {
        constructor() {
            this.label = "Choose database from file";
            this.description = "";
        }
    }
    QuickPick.FileDialogItem = FileDialogItem;
    class ErrorItem {
        constructor(label) {
            this.label = label;
        }
    }
    QuickPick.ErrorItem = ErrorItem;
})(QuickPick = exports.QuickPick || (exports.QuickPick = {}));
/**
 * Show a Quick Pick that lets you choose a database to open from all the files in the workspace with extension .db or .sqlite
 * @param hint What to write in the QuickPick
 */
function pickWorkspaceDatabase(autopick, fileExtensions = [], includeMemory = true, hint) {
    if (fileExtensions == []) {
        fileExtensions = ["db", "db3", "sqlite", "sqlite3", "sdb", "s3db"];
    }
    const promise = new Promise((resolve) => {
        vscode_1.workspace.findFiles('**/*.{' + fileExtensions.join(",") + '}').then((filesUri) => {
            let fileDialogItem = new QuickPick.FileDialogItem();
            let items = filesUri.map(uri => new QuickPick.DatabaseItem(uri.fsPath));
            if (includeMemory)
                items.push(new QuickPick.DatabaseItem(":memory:", "sqlite in-memory database"));
            items.push(fileDialogItem);
            resolve(items);
        });
    });
    return new Promise((resolve, reject) => {
        hint = hint ? hint : 'Choose a database.';
        showAutoQuickPick(autopick, promise, hint).then(item => {
            if (item instanceof QuickPick.DatabaseItem) {
                resolve(item.path);
            }
            else if (item instanceof QuickPick.FileDialogItem) {
                vscode_1.window.showOpenDialog({ filters: { "Database": fileExtensions } }).then(fileUri => {
                    if (fileUri) {
                        resolve(fileUri[0].fsPath);
                    }
                    else {
                        resolve();
                    }
                });
            }
            else {
                resolve();
            }
        });
    });
}
exports.pickWorkspaceDatabase = pickWorkspaceDatabase;
function pickListDatabase(autopick, dbs) {
    let items;
    if (dbs.length === 0) {
        //items = [new QuickPick.ErrorItem('No database found.')];
        items = [];
    }
    else {
        items = dbs.map(dbPath => new QuickPick.DatabaseItem(dbPath));
    }
    return new Promise((resolve, reject) => {
        showAutoQuickPick(autopick, items, 'Choose a database to close.').then((item) => {
            if (item instanceof QuickPick.DatabaseItem) {
                resolve(item.path);
            }
            else {
                reject();
            }
        });
    });
}
exports.pickListDatabase = pickListDatabase;
/**
 * Show a selection list that returns immediatly if autopick is true and there is only one item.
 * Autopick depends on the configuration sqlite.autopick
 * @param hint
 */
function showAutoQuickPick(autopick, items, hint) {
    if (autopick && items instanceof Array && items.length === 1) {
        let item = items[0];
        return new Promise(resolve => resolve(item));
    }
    else {
        return new Promise((resolve, reject) => {
            let cancTockenSource;
            let cancToken;
            /* items is a Thenable, if there is only one item
            i need to resolve the only item and cancel the quickpick */
            if (autopick && !(items instanceof Array)) {
                cancTockenSource = new vscode_1.CancellationTokenSource();
                cancToken = cancTockenSource.token;
                items.then(items => {
                    if (items.length === 1) {
                        let item = items[0];
                        resolve(item);
                        if (cancTockenSource) {
                            cancTockenSource.cancel();
                            cancTockenSource.dispose();
                        }
                    }
                });
            }
            vscode_1.window.showQuickPick(items, { placeHolder: hint ? hint : '' }, cancToken).then(item => {
                resolve(item);
                if (cancTockenSource) {
                    cancTockenSource.dispose();
                }
            });
        });
    }
}
exports.showAutoQuickPick = showAutoQuickPick;
//# sourceMappingURL=quickpick.js.map