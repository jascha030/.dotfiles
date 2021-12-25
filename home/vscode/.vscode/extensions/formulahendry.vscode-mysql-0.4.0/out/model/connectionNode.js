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
const constants_1 = require("../common/constants");
const global_1 = require("../common/global");
const utility_1 = require("../common/utility");
const databaseNode_1 = require("./databaseNode");
const infoNode_1 = require("./infoNode");
class ConnectionNode {
    constructor(id, host, user, password, port, certPath) {
        this.id = id;
        this.host = host;
        this.user = user;
        this.password = password;
        this.port = port;
        this.certPath = certPath;
    }
    getTreeItem() {
        return {
            label: this.host,
            collapsibleState: vscode.TreeItemCollapsibleState.Collapsed,
            contextValue: "connection",
            iconPath: path.join(__filename, "..", "..", "..", "resources", "server.png"),
        };
    }
    getChildren() {
        return __awaiter(this, void 0, void 0, function* () {
            const connection = utility_1.Utility.createConnection({
                host: this.host,
                user: this.user,
                password: this.password,
                port: this.port,
                certPath: this.certPath,
            });
            return utility_1.Utility.queryPromise(connection, "SHOW DATABASES")
                .then((databases) => {
                return databases.map((database) => {
                    return new databaseNode_1.DatabaseNode(this.host, this.user, this.password, this.port, database.Database, this.certPath);
                });
            })
                .catch((err) => {
                return [new infoNode_1.InfoNode(err)];
            });
        });
    }
    newQuery() {
        return __awaiter(this, void 0, void 0, function* () {
            appInsightsClient_1.AppInsightsClient.sendEvent("newQuery", { viewItem: "connection" });
            utility_1.Utility.createSQLTextDocument();
            global_1.Global.activeConnection = {
                host: this.host,
                user: this.user,
                password: this.password,
                port: this.port,
                certPath: this.certPath,
            };
        });
    }
    deleteConnection(context, mysqlTreeDataProvider) {
        return __awaiter(this, void 0, void 0, function* () {
            appInsightsClient_1.AppInsightsClient.sendEvent("deleteConnection");
            const connections = context.globalState.get(constants_1.Constants.GlobalStateMySQLConectionsKey);
            delete connections[this.id];
            yield context.globalState.update(constants_1.Constants.GlobalStateMySQLConectionsKey, connections);
            yield global_1.Global.keytar.deletePassword(constants_1.Constants.ExtensionId, this.id);
            mysqlTreeDataProvider.refresh();
        });
    }
}
exports.ConnectionNode = ConnectionNode;
//# sourceMappingURL=connectionNode.js.map