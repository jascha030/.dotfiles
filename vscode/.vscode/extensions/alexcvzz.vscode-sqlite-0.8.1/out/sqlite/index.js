"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const schema_1 = require("./schema");
const queryExecutor_1 = require("./queryExecutor");
class SQLite {
    constructor(_extensionPath) {
    }
    query(sqliteCommand, dbPath, query) {
        if (!sqliteCommand)
            Promise.resolve({ error: "Unable to execute query: provide a valid sqlite3 executable in the setting sqlite.sqlite3." });
        return queryExecutor_1.executeQuery(sqliteCommand, dbPath, query);
    }
    schema(sqliteCommand, dbPath) {
        if (!sqliteCommand)
            Promise.resolve({ error: "Unable to execute query: provide a valid sqlite3 executable in the setting sqlite.sqlite3." });
        return Promise.resolve(schema_1.Schema.build(dbPath, sqliteCommand));
    }
    dispose() {
        // Nothing to dispose
    }
}
exports.default = SQLite;
//# sourceMappingURL=index.js.map