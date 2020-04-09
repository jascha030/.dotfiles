"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cliDatabase_1 = require("./cliDatabase");
const files_1 = require("../utils/files");
var Schema;
(function (Schema) {
    function build(dbPath, sqlite3) {
        return new Promise((resolve, reject) => {
            if (!files_1.isFileSync(dbPath))
                return reject(new Error(`Failed to retrieve database schema: '${dbPath}' is not a file`));
            let schema = {
                path: dbPath,
                tables: []
            };
            const tablesQuery = `SELECT name, type FROM sqlite_master
                                WHERE (type="table" OR type="view")
                                AND name <> 'sqlite_sequence'
                                AND name <> 'sqlite_stat1'
                                ORDER BY type ASC, name ASC;`;
            let database = new cliDatabase_1.CliDatabase(sqlite3, dbPath, (err) => {
                reject(err);
            });
            database.execute(tablesQuery, (rows, err) => {
                if (err)
                    return reject(err);
                rows.shift(); // remove header from rows
                schema.tables = rows.map(row => {
                    return { database: dbPath, name: row[0], type: row[1], columns: [] };
                });
                for (let table of schema.tables) {
                    let columnQuery = `PRAGMA table_info('${table.name}');`;
                    database.execute(columnQuery, (rows, err) => {
                        if (err)
                            return reject(err);
                        if (rows.length < 2)
                            return;
                        //let tableName = result.stmt.replace(/.+\(\'?(\w+)\'?\).+/, '$1');
                        let header = rows.shift() || [];
                        table.columns = rows.map(row => {
                            return {
                                database: dbPath,
                                table: table.name,
                                name: row[header.indexOf('name')],
                                type: row[header.indexOf('type')].toUpperCase(),
                                notnull: row[header.indexOf('notnull')] === '1' ? true : false,
                                pk: Number(row[header.indexOf('pk')]) || 0,
                                defVal: row[header.indexOf('dflt_value')]
                            };
                        });
                    });
                }
                database.close(() => {
                    resolve(schema);
                });
            });
        });
    }
    Schema.build = build;
})(Schema = exports.Schema || (exports.Schema = {}));
//# sourceMappingURL=schema.js.map