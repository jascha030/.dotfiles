"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
const vscode = require("vscode");
class ColumnNode {
    constructor(host, user, password, port, database, column) {
        this.host = host;
        this.user = user;
        this.password = password;
        this.port = port;
        this.database = database;
        this.column = column;
    }
    getTreeItem() {
        return {
            label: `${this.column.COLUMN_NAME} : ${this.column.COLUMN_TYPE}     \n${this.column.COLUMN_COMMENT}`,
            collapsibleState: vscode.TreeItemCollapsibleState.None,
            contextValue: "column",
            iconPath: path.join(__filename, "..", "..", "..", "resources", this.column.COLUMN_KEY === "PRI" ? "b_primary.png" : "b_props.png"),
        };
    }
    getChildren() {
        return __awaiter(this, void 0, void 0, function* () {
            return [];
        });
    }
}
exports.ColumnNode = ColumnNode;
//# sourceMappingURL=columnNode.js.map