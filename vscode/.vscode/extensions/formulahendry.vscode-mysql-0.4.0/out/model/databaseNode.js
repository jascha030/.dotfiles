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
const appInsightsClient_1 = require("../common/appInsightsClient");
const global_1 = require("../common/global");
const utility_1 = require("../common/utility");
const infoNode_1 = require("./infoNode");
const tableNode_1 = require("./tableNode");
class DatabaseNode {
    constructor(host, user, password, port, database, certPath) {
        this.host = host;
        this.user = user;
        this.password = password;
        this.port = port;
        this.database = database;
        this.certPath = certPath;
    }
    getTreeItem() {
        return {
            label: this.database,
            collapsibleState: vscode.TreeItemCollapsibleState.Collapsed,
            contextValue: "database",
            iconPath: path.join(__filename, "..", "..", "..", "resources", "database.svg"),
        };
    }
    getChildren() {
        return __awaiter(this, void 0, void 0, function* () {
            const connection = utility_1.Utility.createConnection({
                host: this.host,
                user: this.user,
                password: this.password,
                port: this.port,
                database: this.database,
                certPath: this.certPath,
            });
            return utility_1.Utility.queryPromise(connection, `SELECT TABLE_NAME FROM information_schema.TABLES  WHERE TABLE_SCHEMA = '${this.database}' LIMIT ${utility_1.Utility.maxTableCount}`)
                .then((tables) => {
                return tables.map((table) => {
                    return new tableNode_1.TableNode(this.host, this.user, this.password, this.port, this.database, table.TABLE_NAME, this.certPath);
                });
            })
                .catch((err) => {
                return [new infoNode_1.InfoNode(err)];
            });
        });
    }
    newQuery() {
        return __awaiter(this, void 0, void 0, function* () {
            appInsightsClient_1.AppInsightsClient.sendEvent("newQuery", { viewItem: "database" });
            utility_1.Utility.createSQLTextDocument();
            global_1.Global.activeConnection = {
                host: this.host,
                user: this.user,
                password: this.password,
                port: this.port,
                database: this.database,
                certPath: this.certPath,
            };
        });
    }
}
exports.DatabaseNode = DatabaseNode;
//# sourceMappingURL=databaseNode.js.map