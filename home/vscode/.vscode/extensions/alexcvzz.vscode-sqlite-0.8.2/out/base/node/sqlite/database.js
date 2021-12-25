"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cliDatabase_1 = require("./cliDatabase");
var Database;
(function (Database) {
    function open(dbPath, options, callback) {
        switch (options.engine) {
            case "cli":
                let command = options.command ? options.command : "sqlite3";
                return new cliDatabase_1.CliDatabase(command, dbPath, callback);
            default:
                throw Error(`Engine '${options.engine}' not supported.`);
        }
    }
    Database.open = open;
})(Database = exports.Database || (exports.Database = {}));
//# sourceMappingURL=database.js.map