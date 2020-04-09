"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cliDatabase_1 = require("./cliDatabase");
const queryParser_1 = require("./queryParser");
const logger_1 = require("../logging/logger");
function executeQuery(sqlite3, dbPath, query, options = { sql: [] }) {
    if (!sqlite3) {
        return Promise.reject(new Error(`Unable to execute query: SQLite command is not valid: '${sqlite3}'`));
    }
    logger_1.logger.debug(`SQLite3 command: '${sqlite3}'`);
    logger_1.logger.debug(`Database path: '${dbPath}'`);
    logger_1.logger.debug(`Query: ${query}`);
    // extract the statements from the query
    let statements;
    try {
        statements = queryParser_1.extractStatements(query);
    }
    catch (err) {
        return Promise.reject(`Unable to execute query: ${err.message}`);
    }
    logger_1.logger.debug(`Statements:\n${JSON.stringify(statements)}`);
    let resultSet = [];
    let error;
    return new Promise((resolve, reject) => {
        let database;
        database = new cliDatabase_1.CliDatabase(sqlite3, dbPath, (err) => {
            // there was an error opening the database, reject
            reject(err);
        });
        // execute sql before the queries, reject if there is any error
        for (let sql of options.sql) {
            database.execute(sql, (_rows, err) => {
                if (err)
                    reject(new Error(`Failed to execute: '${sql}': ${err.message}`));
            });
        }
        // execute statements
        for (let statement of statements) {
            database.execute(statement.sql, (rows, err) => {
                if (err) {
                    error = err;
                }
                else {
                    let header = rows.length > 1 ? rows.shift() : [];
                    resultSet.push({ stmt: statement.sql, header: header, rows });
                }
            });
        }
        database.close(() => {
            resolve({ resultSet: resultSet, error: error });
        });
    });
}
exports.executeQuery = executeQuery;
//# sourceMappingURL=queryExecutor.js.map