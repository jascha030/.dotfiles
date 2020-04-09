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
const columnNode_1 = require("./columnNode");
const infoNode_1 = require("./infoNode");
class TableNode {
    constructor(host, user, password, port, database, table, certPath) {
        this.host = host;
        this.user = user;
        this.password = password;
        this.port = port;
        this.database = database;
        this.table = table;
        this.certPath = certPath;
    }
    getTreeItem() {
        return {
            label: this.table,
            collapsibleState: vscode.TreeItemCollapsibleState.Collapsed,
            contextValue: "table",
            iconPath: path.join(__filename, "..", "..", "..", "resources", "table.svg"),
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
            return utility_1.Utility.queryPromise(connection, `SELECT * FROM information_schema.columns WHERE table_schema = '${this.database}' AND table_name = '${this.table}';`)
                .then((columns) => {
                return columns.map((column) => {
                    return new columnNode_1.ColumnNode(this.host, this.user, this.password, this.port, this.database, column);
                });
            })
                .catch((err) => {
                return [new infoNode_1.InfoNode(err)];
            });
        });
    }
    selectTop1000() {
        return __awaiter(this, void 0, void 0, function* () {
            appInsightsClient_1.AppInsightsClient.sendEvent("selectTop1000");
            const sql = `SELECT * FROM \`${this.database}\`.\`${this.table}\` LIMIT 1000;`;
            utility_1.Utility.createSQLTextDocument(sql);
            const connection = {
                host: this.host,
                user: this.user,
                password: this.password,
                port: this.port,
                database: this.database,
                certPath: this.certPath,
            };
            global_1.Global.activeConnection = connection;
            utility_1.Utility.runQuery(sql, connection);
        });
    }
}
exports.TableNode = TableNode;
//# sourceMappingURL=tableNode.js.map