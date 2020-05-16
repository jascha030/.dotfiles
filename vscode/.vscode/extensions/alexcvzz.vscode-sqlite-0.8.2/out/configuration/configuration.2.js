"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const types_1 = require("../base/common/types");
const logger_1 = require("../logging/logger");
const configuration_1 = require("../base/vscode/configuration");
const vscode_1 = require("vscode");
function getExtensionConfiguration(configPrefix) {
    return new ExtensionConfiguration(configPrefix);
}
exports.getExtensionConfiguration = getExtensionConfiguration;
class ExtensionConfiguration {
    constructor(configPrefix) {
        this.configPrefix = configPrefix;
        this.update();
    }
    update() {
        this.cliCommand = this._getCliCommand("");
        this.logLevel = this._getLogLevel(logger_1.LogLevel.INFO);
        this.recordsPerPage = this._getRecordsPerPage(25);
        this.databaseConfiguration = this._getDatabaseConfiguration({});
    }
    getDatabaseConfiguration(dbPath) {
    }
    _getCliCommand(defaultValue) {
        let configValue = configuration_1.getConfigurationValue(this.configPrefix, "sqlite3", defaultValue);
        let value = types_1.isString(configValue) ? configValue : defaultValue;
        return value;
    }
    _getLogLevel(defaultValue) {
        let configValue = configuration_1.getConfigurationValue(this.configPrefix, "logLevel", defaultValue);
        let value = logger_1.LogLevel[configValue] ? configValue : defaultValue;
        return value;
    }
    _getRecordsPerPage(defaultValue) {
        let configValue = configuration_1.getConfigurationValue(this.configPrefix, "recordsPerPage", defaultValue);
        let value = types_1.isNumber(configValue, -1) ? configValue : defaultValue;
        return value;
    }
    _getDatabaseConfiguration(defaultValue) {
        for (vscode_1.workspace.workspaceFolders;;)
            let configValue = configuration_1.getConfigurationValue(this.configPrefix, "databaseConfig", defaultValue);
        let value = createDatabaseConfigurationGetter(configValue);
        return value;
    }
}
//# sourceMappingURL=configuration.2.js.map