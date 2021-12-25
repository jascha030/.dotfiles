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
const uuidv1 = require("uuid/v1");
const vscode = require("vscode");
const appInsightsClient_1 = require("./common/appInsightsClient");
const constants_1 = require("./common/constants");
const global_1 = require("./common/global");
const connectionNode_1 = require("./model/connectionNode");
class MySQLTreeDataProvider {
    constructor(context) {
        this.context = context;
        this._onDidChangeTreeData = new vscode.EventEmitter();
        this.onDidChangeTreeData = this._onDidChangeTreeData.event;
    }
    getTreeItem(element) {
        return element.getTreeItem();
    }
    getChildren(element) {
        if (!element) {
            return this.getConnectionNodes();
        }
        return element.getChildren();
    }
    addConnection() {
        return __awaiter(this, void 0, void 0, function* () {
            appInsightsClient_1.AppInsightsClient.sendEvent("addConnection.start");
            const host = yield vscode.window.showInputBox({ prompt: "The hostname of the database", placeHolder: "host", ignoreFocusOut: true });
            if (!host) {
                return;
            }
            const user = yield vscode.window.showInputBox({ prompt: "The MySQL user to authenticate as", placeHolder: "user", ignoreFocusOut: true });
            if (!user) {
                return;
            }
            const password = yield vscode.window.showInputBox({ prompt: "The password of the MySQL user", placeHolder: "password", ignoreFocusOut: true, password: true });
            if (password === undefined) {
                return;
            }
            const port = yield vscode.window.showInputBox({ prompt: "The port number to connect to", placeHolder: "port", ignoreFocusOut: true, value: "3306" });
            if (!port) {
                return;
            }
            const certPath = yield vscode.window.showInputBox({ prompt: "[Optional] SSL certificate path. Leave empty to ignore", placeHolder: "certificate file path", ignoreFocusOut: true });
            if (certPath === undefined) {
                return;
            }
            let connections = this.context.globalState.get(constants_1.Constants.GlobalStateMySQLConectionsKey);
            if (!connections) {
                connections = {};
            }
            const id = uuidv1();
            connections[id] = {
                host,
                user,
                port,
                certPath,
            };
            if (password) {
                yield global_1.Global.keytar.setPassword(constants_1.Constants.ExtensionId, id, password);
            }
            yield this.context.globalState.update(constants_1.Constants.GlobalStateMySQLConectionsKey, connections);
            this.refresh();
            appInsightsClient_1.AppInsightsClient.sendEvent("addConnection.end");
        });
    }
    refresh(element) {
        this._onDidChangeTreeData.fire(element);
    }
    getConnectionNodes() {
        return __awaiter(this, void 0, void 0, function* () {
            const connections = this.context.globalState.get(constants_1.Constants.GlobalStateMySQLConectionsKey);
            const ConnectionNodes = [];
            if (connections) {
                for (const id of Object.keys(connections)) {
                    const password = yield global_1.Global.keytar.getPassword(constants_1.Constants.ExtensionId, id);
                    ConnectionNodes.push(new connectionNode_1.ConnectionNode(id, connections[id].host, connections[id].user, password, connections[id].port, connections[id].certPath));
                    if (!global_1.Global.activeConnection) {
                        global_1.Global.activeConnection = {
                            host: connections[id].host,
                            user: connections[id].user,
                            password,
                            port: connections[id].port,
                            certPath: connections[id].certPath,
                        };
                    }
                }
            }
            return ConnectionNodes;
        });
    }
}
exports.MySQLTreeDataProvider = MySQLTreeDataProvider;
//# sourceMappingURL=mysqlTreeDataProvider.js.map