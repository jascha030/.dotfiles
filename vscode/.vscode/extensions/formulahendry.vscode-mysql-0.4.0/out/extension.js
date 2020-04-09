"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const appInsightsClient_1 = require("./common/appInsightsClient");
const utility_1 = require("./common/utility");
const mysqlTreeDataProvider_1 = require("./mysqlTreeDataProvider");
function activate(context) {
    appInsightsClient_1.AppInsightsClient.sendEvent("loadExtension");
    const mysqlTreeDataProvider = new mysqlTreeDataProvider_1.MySQLTreeDataProvider(context);
    context.subscriptions.push(vscode.window.registerTreeDataProvider("mysql", mysqlTreeDataProvider));
    context.subscriptions.push(vscode.commands.registerCommand("mysql.refresh", (node) => {
        appInsightsClient_1.AppInsightsClient.sendEvent("refresh");
        mysqlTreeDataProvider.refresh(node);
    }));
    context.subscriptions.push(vscode.commands.registerCommand("mysql.addConnection", () => {
        mysqlTreeDataProvider.addConnection();
    }));
    context.subscriptions.push(vscode.commands.registerCommand("mysql.deleteConnection", (connectionNode) => {
        connectionNode.deleteConnection(context, mysqlTreeDataProvider);
    }));
    context.subscriptions.push(vscode.commands.registerCommand("mysql.runQuery", () => {
        utility_1.Utility.runQuery();
    }));
    context.subscriptions.push(vscode.commands.registerCommand("mysql.newQuery", (databaseOrConnectionNode) => {
        databaseOrConnectionNode.newQuery();
    }));
    context.subscriptions.push(vscode.commands.registerCommand("mysql.selectTop1000", (tableNode) => {
        tableNode.selectTop1000();
    }));
}
exports.activate = activate;
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map