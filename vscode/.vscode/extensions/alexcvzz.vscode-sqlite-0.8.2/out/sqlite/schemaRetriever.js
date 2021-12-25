"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const files_1 = require("../base/node/files");
const database_1 = require("../base/node/sqlite/database");
function retrieveSchema(dbPath) {
    return new Promise((resolve, reject) => {
        // make sure the path is a a valid file path
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
        let database = database_1.Database.open(dbPath, { engine: "cli", cliCommand:  }, (err) => {
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
exports.retrieveSchema = retrieveSchema;
//# sourceMappingURL=schemaRetriever.js.map