"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const settings_1 = require("./settings");
const vscode_1 = require("vscode");
const types_1 = require("../base/common/types");
const matchMap_1 = require("../base/common/matchMap");
const globs_1 = require("../base/node/globs");
const objects_1 = require("../base/common/objects");
const path_1 = require("path");
function getExtensionConfiguration() {
    return new ExtensionConfigurationImpl();
}
exports.getExtensionConfiguration = getExtensionConfiguration;
class ExtensionConfigurationImpl {
    constructor() {
        this.settings = settings_1.getSettings();
        this.cliCommand = this.settings.sqlite3;
        this.logLevel = this.settings.logLevel;
        this.recordsPerPage = this.settings.recordsPerPage;
    }
    update() {
        this.settings = settings_1.getSettings();
    }
    getDatabaseConfig(db) {
        let databaseConfigSettings = this.getDatabaseConfigSettings(db);
        let sqlAfterOpen = "";
        if (databaseConfigSettings.enableForeignKeys)
            sqlAfterOpen += this.buildEnableForeignKeysQuery();
        databaseConfigSettings.attachDatabases.forEach(db => sqlAfterOpen += this.buildAttachDatabaseQuery(this.getDatabaseFolderPath(db.path), db));
        let query = databaseConfigSettings.executeAfterOpen.map(q => q.trim()).map(q => q.endsWith(";") ? q + ";" : q).join("\n");
        sqlAfterOpen += query;
        let databaseConfig = {
            sqlAfterOpen: sqlAfterOpen
        };
        return databaseConfig;
    }
    getDatabaseConfigSettings(db) {
        let folderPath = this.getDatabaseFolderPath(db);
        let databaseConfigSettingsGlobMap = folderPath ? this.settings.databaseConfig[folderPath] : this.settings.databaseConfig.__workspace__;
        let globMatcher = { match: (glob, str) => globs_1.match(glob, str, false) };
        let databaseConfigSettingsMatchMap = new matchMap_1.MatchMap(globMatcher, databaseConfigSettingsGlobMap);
        let dbPath = db ? (types_1.isString(db) ? db : db.fsPath) : "";
        let matchingDatabaseConfigSettings = databaseConfigSettingsMatchMap.get(dbPath);
        let databaseConfigSettings = matchingDatabaseConfigSettings.reduce((prev, curr, _idx, _arr) => objects_1.mixin(prev, curr));
        return databaseConfigSettings;
    }
    getDatabaseFolderPath(db) {
        let folderPath;
        if (db) {
            let dbUri = types_1.isString(db) ? vscode_1.Uri.parse(db) : db;
            let folderUri = vscode_1.workspace.getWorkspaceFolder(dbUri);
            folderPath = folderUri ? folderUri.uri.fsPath : undefined;
        }
        else {
            folderPath = undefined;
        }
        return folderPath;
    }
    buildEnableForeignKeysQuery() {
        return "PRAGMA foreign_keys = ON;\n";
    }
    buildAttachDatabaseQuery(basePath, db) {
        let dbPath = path_1.isAbsolute(db.path) ? db.path : (basePath ? path_1.join(basePath, db.path) : db.path);
        let query = `ATTACH ${dbPath} AS ${db.alias};\n`;
        return query;
    }
}
//# sourceMappingURL=extensionConfiguration.js.map