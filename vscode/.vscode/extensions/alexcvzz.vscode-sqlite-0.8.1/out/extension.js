'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const vscodewrapper_1 = require("./vscodewrapper");
const logger_1 = require("./logging/logger");
const configuration_1 = require("./configuration");
const constants_1 = require("./constants/constants");
const sqlworkspace_1 = require("./sqlworkspace");
const sqlite_1 = require("./sqlite");
const resultview_1 = require("./resultview");
const languageserver_1 = require("./languageserver");
const explorer_1 = require("./explorer");
const sqliteCommandValidation_1 = require("./sqlite/sqliteCommandValidation");
const clipboard_1 = require("./utils/clipboard");
const queryParser_1 = require("./sqlite/queryParser");
var Commands;
(function (Commands) {
    Commands.showOutputChannel = "sqlite.showOutputChannel";
    Commands.runDocumentQuery = "sqlite.runDocumentQuery";
    Commands.runSelectedQuery = "sqlite.runSelectedQuery";
    Commands.useDatabase = 'sqlite.useDatabase';
    Commands.explorerAdd = 'sqlite.explorer.add';
    Commands.explorerRemove = 'sqlite.explorer.remove';
    Commands.explorerRefresh = 'sqlite.explorer.refresh';
    Commands.explorerCopyName = 'sqlite.explorer.copyName';
    Commands.explorerCopyPath = 'sqlite.explorer.copyPath';
    Commands.explorerCopyRelativePath = 'sqlite.explorer.copyRelativePath';
    Commands.newQuery = 'sqlite.newQuery';
    Commands.newQuerySelect = 'sqlite.newQuerySelect';
    Commands.newQueryInsert = 'sqlite.newQueryInsert';
    Commands.quickQuery = 'sqlite.quickQuery';
    Commands.runTableQuery = 'sqlite.runTableQuery';
    Commands.runSqliteMasterQuery = 'sqlite.runSqliteMasterQuery';
})(Commands = exports.Commands || (exports.Commands = {}));
let sqliteCommand;
let configuration;
let languageserver;
let sqlWorkspace;
let sqlite;
let explorer;
let resultView;
function activate(context) {
    logger_1.logger.info(`Activating extension ${constants_1.Constants.extensionName} v${constants_1.Constants.extensionVersion}...`);
    // load configuration and reload every time it's changed
    configuration = configuration_1.getConfiguration();
    logger_1.logger.setLogLevel(configuration.logLevel);
    setSqliteCommand(configuration.sqlite3, context.extensionPath);
    context.subscriptions.push(vscode_1.workspace.onDidChangeConfiguration(() => {
        configuration = configuration_1.getConfiguration();
        logger_1.logger.setLogLevel(configuration.logLevel);
        setSqliteCommand(configuration.sqlite3, context.extensionPath);
    }));
    // initialize modules
    languageserver = new languageserver_1.default();
    sqlWorkspace = new sqlworkspace_1.default();
    sqlite = new sqlite_1.default(context.extensionPath);
    explorer = new explorer_1.default();
    resultView = new resultview_1.default(context.extensionPath);
    languageserver.setSchemaHandler(doc => {
        let dbPath = sqlWorkspace.getDocumentDatabase(doc);
        if (dbPath)
            return sqlite.schema(sqliteCommand, dbPath);
        else
            return Promise.resolve();
    });
    context.subscriptions.push(languageserver, sqlWorkspace, sqlite, explorer, resultView);
    // register commands
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.showOutputChannel, () => {
        logger_1.logger.showOutput();
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.runDocumentQuery, () => {
        return runDocumentQuery();
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.runSelectedQuery, () => {
        return runSelectedQuery();
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.explorerAdd, (dbUri) => {
        let dbPath = dbUri ? dbUri.fsPath : undefined;
        return explorerAdd(dbPath);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.explorerRemove, (item) => {
        let dbPath = item ? item.path : undefined;
        return explorerRemove(dbPath);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.explorerRefresh, () => {
        return explorerRefresh();
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.explorerCopyName, (item) => {
        let name = item.name;
        return copyToClipboard(name);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.explorerCopyPath, (item) => {
        let path = item.path;
        return copyToClipboard(path);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.explorerCopyRelativePath, (item) => {
        let path = vscode_1.workspace.asRelativePath(item.path);
        return copyToClipboard(path);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.useDatabase, () => {
        return useDatabase();
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.newQuery, (db) => {
        let dbPath = db ? db.path : undefined;
        return newQuery(dbPath);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.newQuerySelect, (table) => {
        return newQuerySelect(table);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.newQueryInsert, (table) => {
        return newQueryInsert(table);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.quickQuery, () => {
        return quickQuery();
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.runTableQuery, (table) => {
        return runTableQuery(table.database, table.name);
    }));
    context.subscriptions.push(vscode_1.commands.registerCommand(Commands.runSqliteMasterQuery, (db) => {
        return runSqliteMasterQuery(db.path);
    }));
    logger_1.logger.info(`Extension activated.`);
    return Promise.resolve(true);
}
exports.activate = activate;
function runDocumentQuery() {
    let sqlDocument = vscodewrapper_1.getEditorSqlDocument();
    if (sqlDocument) {
        let dbPath = sqlWorkspace.getDocumentDatabase(sqlDocument);
        if (dbPath) {
            // let selection = getEditorSelection();
            let query = sqlDocument.getText();
            runQuery(dbPath, query, true);
        }
        else {
            useDatabase().then(dbPath => {
                if (dbPath)
                    runDocumentQuery();
            });
        }
    }
}
function runSelectedQuery() {
    let sqlDocument = vscodewrapper_1.getEditorSqlDocument();
    if (sqlDocument) {
        let dbPath = sqlWorkspace.getDocumentDatabase(sqlDocument);
        if (dbPath) {
            let selection = vscodewrapper_1.getEditorSelection();
            let query = "";
            if (!selection) {
                query = sqlDocument.getText();
            }
            else if (selection.isEmpty) {
                let text = sqlDocument.getText();
                let statements = queryParser_1.extractStatements(text);
                // find the statement that includes the selection
                for (let stmt of statements) {
                    let stmtStartPosition = new vscode_1.Position(stmt.position.start[0], stmt.position.start[1]);
                    let stmtEndPosition = new vscode_1.Position(stmt.position.end[0], stmt.position.end[1] + 1);
                    let stmtRange = new vscode_1.Range(stmtStartPosition, stmtEndPosition);
                    if (stmtRange.contains(selection)) {
                        query = stmt.sql;
                        break;
                    }
                }
            }
            else {
                query = sqlDocument.getText(selection);
            }
            if (query != "") {
                runQuery(dbPath, query, true);
            }
            else {
                let message = `No query selected.`;
                vscodewrapper_1.showErrorMessage(message, { title: "Show output", command: Commands.showOutputChannel });
            }
        }
        else {
            useDatabase().then(dbPath => {
                if (dbPath)
                    runDocumentQuery();
            });
        }
    }
}
function quickQuery() {
    vscodewrapper_1.pickWorkspaceDatabase(false, configuration.databaseExtensions, true).then(dbPath => {
        if (dbPath) {
            vscodewrapper_1.showQueryInputBox(dbPath).then(query => {
                if (query)
                    runQuery(dbPath, query, true);
            });
        }
    });
}
function useDatabase() {
    let sqlDocument = vscodewrapper_1.getEditorSqlDocument();
    return vscodewrapper_1.pickWorkspaceDatabase(false, configuration.databaseExtensions, true).then(dbPath => {
        if (sqlDocument && dbPath)
            sqlWorkspace.bindDatabaseToDocument(dbPath, sqlDocument);
        return Promise.resolve(dbPath);
    });
}
function explorerAdd(dbPath) {
    if (dbPath) {
        return sqlite.schema(sqliteCommand, dbPath).then(schema => {
            return explorer.add(schema);
        }, err => {
            let message = `Failed to open database: ${err.message}`;
            vscodewrapper_1.showErrorMessage(message, { title: "Show output", command: Commands.showOutputChannel });
        });
    }
    else {
        return vscodewrapper_1.pickWorkspaceDatabase(false, configuration.databaseExtensions, false).then(dbPath => {
            if (dbPath)
                return explorerAdd(dbPath);
        }, onrejected => {
            // No database selected
        });
    }
}
function explorerRemove(dbPath) {
    if (dbPath) {
        return Promise.resolve(explorer.remove(dbPath));
    }
    else {
        let dbList = explorer.list().map(db => db.path);
        return vscodewrapper_1.pickListDatabase(false, dbList).then(dbPath => {
            if (dbPath)
                return explorerRemove(dbPath);
        }, onrejected => {
            // fail silently
        });
    }
}
function explorerRefresh() {
    let dbList = explorer.list();
    return Promise.all(dbList.map(db => {
        let dbPath = db.path;
        return sqlite.schema(sqliteCommand, dbPath).then(schema => {
            return explorer.add(schema);
        }, err => {
            // remove the database from the explorer
            explorer.remove(dbPath);
            // show error message
            let message = `Failed to refresh database: ${err.message}`;
            logger_1.logger.error(message);
            vscodewrapper_1.showErrorMessage(message, { title: "Show output", command: Commands.showOutputChannel });
        });
    }));
}
function newQuerySelect(table) {
    let contentL0 = `SELECT ${table.columns.map(c => c.name).join(", ")}`;
    let contentL1 = `FROM \`${table.name}\`;`;
    let content = contentL0 + "\n" + contentL1;
    let cursorPos = new vscode_1.Position(1, contentL1.length - 1);
    return newQuery(table.database, content, cursorPos);
}
function newQueryInsert(table) {
    let contentL0 = `INSERT INTO \`${table.name}\` (${table.columns.map(c => c.name).join(", ")})`;
    let contentL1 = `VALUES ();`;
    let content = contentL0 + "\n" + contentL1;
    // move the cursor inside the round brackets
    let cursorPos = new vscode_1.Position(1, contentL1.length - 2);
    return newQuery(table.database, content, cursorPos);
}
function newQuery(dbPath, content = "", cursorPos = new vscode_1.Position(0, 0)) {
    return vscodewrapper_1.createSqlDocument(content, cursorPos, true).then(sqlDocument => {
        if (dbPath)
            sqlWorkspace.bindDatabaseToDocument(dbPath, sqlDocument);
        return Promise.resolve(sqlDocument);
    });
}
function runTableQuery(dbPath, tableName) {
    let query = `SELECT * FROM \`${tableName}\`;`;
    runQuery(dbPath, query, true);
}
function runSqliteMasterQuery(dbPath) {
    let query = `SELECT * FROM sqlite_master;`;
    runQuery(dbPath, query, true);
}
function runQuery(dbPath, query, display) {
    let resultSet = sqlite.query(sqliteCommand, dbPath, query).then(({ resultSet, error }) => {
        // log and show if there is any error
        if (error) {
            logger_1.logger.error(error.message);
            vscodewrapper_1.showErrorMessage(error.message, { title: "Show output", command: Commands.showOutputChannel });
        }
        return resultSet;
    });
    if (display) {
        resultView.display(resultSet, configuration.recordsPerPage);
    }
}
function setSqliteCommand(command, extensionPath) {
    try {
        sqliteCommand = sqliteCommandValidation_1.validateSqliteCommand(command, extensionPath);
    }
    catch (e) {
        logger_1.logger.error(e.message);
        vscodewrapper_1.showErrorMessage(e.message, { title: "Show output", command: Commands.showOutputChannel });
        sqliteCommand = "";
    }
}
function copyToClipboard(text) {
    return clipboard_1.default.copy(text).then(() => {
        return vscode_1.window.setStatusBarMessage(`Copied '${text}' to clipboard.`, 2000);
    });
}
// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map