"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const path_1 = require("path");
class SQLItem extends vscode_1.TreeItem {
    constructor(name, label, collapsibleState, command) {
        super(label, collapsibleState);
        this.name = name;
        this.label = label;
        this.collapsibleState = collapsibleState;
        this.command = command;
    }
}
exports.SQLItem = SQLItem;
class DBItem extends SQLItem {
    constructor(dbPath, command) {
        super(dbPath, path_1.basename(dbPath), vscode_1.TreeItemCollapsibleState.Collapsed, command);
        this.dbPath = dbPath;
        this.iconPath = {
            light: path_1.join(__filename, '..', '..', '..', 'resources', 'light', 'database.svg'),
            dark: path_1.join(__filename, '..', '..', '..', 'resources', 'dark', 'database.svg')
        };
        this.contextValue = 'sqlite.databaseItem';
    }
    get tooltip() {
        return `${this.dbPath}`;
    }
}
exports.DBItem = DBItem;
class TableItem extends SQLItem {
    constructor(name, type, command) {
        super(name, name, vscode_1.TreeItemCollapsibleState.Collapsed, command);
        this.type = type;
        this.contextValue = 'sqlite.tableItem';
        let icon_name = "table.svg";
        if (this.type === "view") {
            icon_name = "table_view.svg";
        }
        this.iconPath = {
            light: path_1.join(__filename, '..', '..', '..', 'resources', 'light', icon_name),
            dark: path_1.join(__filename, '..', '..', '..', 'resources', 'dark', icon_name)
        };
    }
    get tooltip() {
        //var dbName = basename(dirname(this.id));
        //var dbNameNoExtension = dbName.substr(0, dbName.lastIndexOf('.')) || dbName;
        return `${this.name}\n${this.type === "view" ? "VIEW" : "TABLE"}`;
    }
}
exports.TableItem = TableItem;
class ColumnItem extends SQLItem {
    constructor(name, type, notnull, pk, defVal, command) {
        super(name, name + ` : ${type.toLowerCase()}`, vscode_1.TreeItemCollapsibleState.None, command);
        this.type = type;
        this.notnull = notnull;
        this.pk = pk;
        this.defVal = defVal;
        this.contextValue = 'sqlite.columnItem';
        let iconName = notnull ? 'col_notnull.svg' : 'col_nullable.svg';
        iconName = pk > 0 ? 'col_pk.svg' : iconName;
        this.iconPath = {
            light: path_1.join(__filename, '..', '..', '..', 'resources', 'light', iconName),
            dark: path_1.join(__filename, '..', '..', '..', 'resources', 'dark', iconName)
        };
    }
    get tooltip() {
        let pkTooltip = this.pk ? '\nPRIMARY KEY' : '';
        let notnullTooltip = this.notnull ? '\nNOT NULL' : '';
        let defvalTooltip = this.defVal !== 'NULL' ? `\nDEFAULT: ${this.defVal}` : '';
        return `${this.name}\n${this.type}${pkTooltip}${notnullTooltip}${defvalTooltip}`;
    }
}
exports.ColumnItem = ColumnItem;
//# sourceMappingURL=treeItem.js.map