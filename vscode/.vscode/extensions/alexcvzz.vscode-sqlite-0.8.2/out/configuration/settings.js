"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const configuration_1 = require("../base/vscode/configuration");
const util_1 = require("util");
const logger_1 = require("../logging/logger");
const types_1 = require("../base/common/types");
function getSettings() {
    let prefix = "sqlite";
    let sqlite3 = getSqlite3(prefix);
    let logLevel = getLogLevel(prefix);
    let recordsPerPage = getRecordsPerPage(prefix);
    let enableForeignKeys = getEnableForeignKeys(prefix);
    let setupDatabase = getSetupDatabase(prefix);
    let settings = {
        sqlite3: sqlite3,
        logLevel: logLevel,
        recordsPerPage: recordsPerPage,
        enableForeignKeys: enableForeignKeys,
        setupDatabase: setupDatabase
    };
    return settings;
}
exports.getSettings = getSettings;
function getSqlite3(prefix) {
    let defaultValue = "";
    let value = configuration_1.getConfigurationValue(prefix, "sqlite3", defaultValue);
    let isValid = util_1.isString(value);
    if (!isValid)
        value = defaultValue;
    return value;
}
function getLogLevel(prefix) {
    let defaultValue = logger_1.LogLevel.INFO;
    let value = configuration_1.getConfigurationValue(prefix, "logLevel", defaultValue);
    let isValid = util_1.isString(value) && Boolean(logger_1.LogLevel[value.toUpperCase()]);
    if (!isValid)
        value = defaultValue;
    return value;
}
function getRecordsPerPage(prefix) {
    let defaultValue = 25;
    let value = configuration_1.getConfigurationValue(prefix, "recordsPerPage", defaultValue);
    let isValid = types_1.isNumber(value, -1);
    if (!isValid)
        value = defaultValue;
    return value;
}
function getEnableForeignKeys(prefix) {
    let defaultValue = false;
    let value = getResourceSetting(prefix, "enableForeignKeys", defaultValue);
    for (let key in value) {
        if (value[key] !== true && value[key] !== false)
            value[key] = defaultValue;
    }
    return value;
}
function getSetupDatabase(prefix) {
    let defaultValue = {};
    let value = getResourceSetting(prefix, "setupDatabase", defaultValue);
    for (let key in value) {
        if (!util_1.isObject(value[key])) {
            delete value[key];
            continue;
        }
        for (let path in value[key]) {
            if (!types_1.isArray(value[key][path].attachDatabases))
                value[key][path].attachDatabases = [];
            if (!types_1.isArray(value[key][path].sql))
                value[key][path].sql = [];
        }
    }
    return value;
}
function getResourceSetting(prefix, section, defaultValue) {
    let resourceSetting = {
        __workspace__: configuration_1.getConfigurationValue(prefix, section, defaultValue)
    };
    // get the configuration for each folder in the workspace
    let foldersUris = vscode_1.workspace.workspaceFolders ? vscode_1.workspace.workspaceFolders.map(folder => folder.uri) : [];
    foldersUris.forEach(folderUri => {
        resourceSetting[folderUri.fsPath] = configuration_1.getConfigurationValue(prefix, section, defaultValue, folderUri);
    });
    return resourceSetting;
}
//# sourceMappingURL=settings.js.map