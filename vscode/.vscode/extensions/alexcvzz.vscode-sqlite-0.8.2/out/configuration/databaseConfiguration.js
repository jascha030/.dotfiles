"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const matchMap_1 = require("../base/common/matchMap");
const types_1 = require("../base/common/types");
const globs_1 = require("../base/node/globs");
class ExtensionDatabaseConfigMap {
    constructor(defaultDatabaseConfiguration) {
        this.defaultDatabaseConfiguration = defaultDatabaseConfiguration;
    }
    set(key, value) {
        let databaseConfigurationMatchMap = this.objectToDatabaseConfigurationMatchMap(value);
        this.map.set(key, databaseConfigurationMatchMap);
    }
    get(key) {
        let databaseConfigurationMatchMap = this.map.get(key);
        if (!databaseConfigurationMatchMap)
            return this.defaultDatabaseConfiguration;
        let databaseConfigurationArray = databaseConfigurationMatchMap.get(key);
        let databaseConfiguration = this.mixinDatabaseConfigurations(databaseConfigurationArray);
        return databaseConfiguration;
    }
    mixinDatabaseConfigurations(databaseConfigurationArray) {
        if (databaseConfigurationArray === [])
            return this.defaultDatabaseConfiguration;
        let databaseConfiguration = {
            executeAfterOpen: "",
            executeBeforeClose: "",
            sqlBeforeStatement: [],
            sqlAfterStatement: [],
            tableQueryConfiguration: 
        };
        databaseConfigurationArray.forEach(conf => {
        });
    }
    objectToDatabaseConfigurationMatchMap(obj) {
        let matchMap = new matchMap_1.MatchMap();
        if (!types_1.isObject(obj, true))
            return matchMap;
        Object.keys(obj).forEach(key => {
            let matchable = {
                match: (str) => {
                    if (key === "[default]")
                        return true;
                    return globs_1.match(key, str, false);
                }
            };
            let databaseConfiguration = this.objectToDatabaseConfiguration(obj[key]);
            matchMap.set(matchable, databaseConfiguration);
        });
        return matchMap;
    }
    objectToDatabaseConfiguration(obj) {
        let;
    }
}
exports.ExtensionDatabaseConfigMap = ExtensionDatabaseConfigMap;
//# sourceMappingURL=databaseConfiguration.js.map