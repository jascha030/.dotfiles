"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const settings_1 = require("./settings");
const vscode_1 = require("vscode");
const types_1 = require("../base/common/types");
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
        this.cliCommand = this.settings.sqlite3;
        this.logLevel = this.settings.logLevel;
        this.recordsPerPage = this.settings.recordsPerPage;
    }
    getSqlAfterOpen(resource) {
        let sql = "";
        let enableForeignKeys = this.getResourceSettingValue(this.settings.enableForeignKeys, resource);
        let setupDatabaseSettings = this.getSetupDatabaseSettings(resource);
        sql += this.buildEnableForeignKeysQuery(enableForeignKeys);
        if (setupDatabaseSettings) {
            sql += this.buildAttachDatabaseQuery(setupDatabaseSettings.attachDatabases);
            sql += this.buildQueryFromList(setupDatabaseSettings.sql);
        }
        return sql;
    }
    getSetupDatabaseSettings(resource) {
        let setupDatabase = this.getResourceSettingValue(this.settings.setupDatabase, resource);
        let path = resource ? (types_1.isString(resource) ? resource : resource.fsPath) : "";
        let setupDatabaseSettings = undefined;
        let folderPath = this.getDatabaseFolderPath(path);
        for (let settingPath in setupDatabase) {
            let absSettingPath = path_1.isAbsolute(settingPath) || !folderPath ? settingPath : path_1.join(folderPath, settingPath);
            let absPath = path_1.isAbsolute(path) || !folderPath ? path : path_1.join(folderPath, path);
            if (absPath === absSettingPath) {
                setupDatabaseSettings = setupDatabase[settingPath];
                return setupDatabaseSettings;
            }
        }
        return setupDatabaseSettings;
    }
    getResourceSettingValue(resourceSetting, resource) {
        let folderPath = this.getDatabaseFolderPath(resource);
        let value = folderPath ? resourceSetting[folderPath] : resourceSetting.__workspace__;
        return value;
    }
    getDatabaseFolderPath(db) {
        let folderPath;
        if (db) {
            let dbUri = types_1.isString(db) ? vscode_1.Uri.file(db) : db;
            let folderUri = vscode_1.workspace.getWorkspaceFolder(dbUri);
            folderPath = folderUri ? folderUri.uri.fsPath : undefined;
        }
        else {
            folderPath = undefined;
        }
        return folderPath;
    }
    buildEnableForeignKeysQuery(enableForeignKeys) {
        if (!enableForeignKeys)
            return "";
        return "PRAGMA foreign_keys = ON;\n";
    }
    buildAttachDatabaseQuery(attach) {
        let query = "";
        attach.forEach(db => {
            let basePath = this.getDatabaseFolderPath(db.path);
            let dbPath = path_1.isAbsolute(db.path) ? db.path : (basePath ? path_1.join(basePath, db.path) : db.path);
            query += `ATTACH ${dbPath} AS ${db.alias};\n`;
        });
        return query;
    }
    buildQueryFromList(sql) {
        return sql.map(q => q.trim()).map(q => q.endsWith(";") ? q + ";" : q).join("\n");
    }
}
//# sourceMappingURL=configuration.js.map