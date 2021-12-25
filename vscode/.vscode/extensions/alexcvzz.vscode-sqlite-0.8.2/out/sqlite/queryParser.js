"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const statement_1 = require("./interfaces/statement");
function extractStatements(query) {
    let statements = [];
    let statement;
    let isStmt = false;
    let isString = false;
    let isComment = false;
    let isCommand = false;
    let commentChar = '';
    let stringChar = '';
    let queryLines = query.split(/\r?\n/);
    for (let lineIndex = 0; lineIndex < queryLines.length; lineIndex++) {
        let line = queryLines[lineIndex];
        for (let charIndex = 0; charIndex < line.length; charIndex++) {
            let char = line[charIndex];
            let prevChar = charIndex > 0 ? line[charIndex - 1] : undefined;
            let nextChar = charIndex < line.length - 1 ? line[charIndex + 1] : undefined;
            if (isStmt) {
                if (statement)
                    statement.sql += char;
                if (!isString && char === ';') {
                    isStmt = false;
                    if (statement) {
                        statement.position.end = [lineIndex, charIndex];
                        statements.push(statement);
                        statement = undefined;
                    }
                }
                else if (!isString && char === '\'') {
                    isString = true;
                    stringChar = '\'';
                }
                else if (!isString && char === '"') {
                    isString = true;
                    stringChar = '"';
                }
                else if (isString && char === stringChar) {
                    isString = false;
                    stringChar = '';
                }
            }
            else if (isComment && commentChar === '-') {
                // skip char
            }
            else if (isComment && commentChar === '/') {
                if (char === '/' && prevChar === '*') {
                    isComment = false;
                    commentChar = '';
                }
            }
            else if (isCommand) {
                if (statement)
                    statement.sql += char;
            }
            else if (char === ' ' || char === '\t') {
                // skip this char
            }
            else if (char === '-' && nextChar === '-') {
                isComment = true;
                commentChar = '-';
            }
            else if (char === '/' && nextChar === '*') {
                isComment = true;
                commentChar = '/';
            }
            else if (char === '.') {
                isCommand = true;
                statement = { sql: char, position: { start: [lineIndex, charIndex], end: [lineIndex, charIndex] }, type: statement_1.StatementType.COMMAND };
            }
            else if (char.match(/\w/)) {
                isStmt = true;
                statement = { sql: char, position: { start: [lineIndex, charIndex], end: [lineIndex, charIndex] }, type: statement_1.StatementType.OTHER };
            }
            else {
                throw Error("Not a valid query");
            }
        }
        if (isCommand) {
            isCommand = false;
            if (statement) {
                statement.position.end = [lineIndex, line.length - 1];
                statements.push(statement);
                statement = undefined;
            }
        }
        if (isComment && commentChar === '-') {
            isComment = false;
            commentChar = '';
        }
        if (isStmt) {
            if (statement)
                statement.sql += "\n";
        }
    }
    // if there is only one statement that does not end with ';'
    // we trim() and add ';' at the end
    // Note: this behaviour is mainly for the extension command sqlite.quickQuery
    if (statement && statements.length === 0) {
        statement.sql = statement.sql.trim() + ';';
        statements.push(statement);
    }
    statements.forEach(statement => statement.type = categorizeStatement(statement.sql));
    return statements;
}
exports.extractStatements = extractStatements;
function categorizeStatement(sql) {
    let type;
    sql = sql.toLowerCase();
    if (sql.startsWith(statement_1.StatementType.SELECT.toLowerCase())) {
        type = statement_1.StatementType.SELECT;
    }
    else if (sql.startsWith(statement_1.StatementType.INSERT.toLowerCase())) {
        type = statement_1.StatementType.INSERT;
    }
    else if (sql.startsWith(statement_1.StatementType.UPDATE.toLowerCase())) {
        type = statement_1.StatementType.UPDATE;
    }
    else if (sql.startsWith(statement_1.StatementType.EXPLAIN.toLowerCase())) {
        type = statement_1.StatementType.EXPLAIN;
    }
    else if (sql.startsWith(statement_1.StatementType.PRAGMA.toLowerCase())) {
        type = statement_1.StatementType.PRAGMA;
    }
    else if (sql.startsWith('.')) {
        type = statement_1.StatementType.COMMAND;
    }
    else {
        type = statement_1.StatementType.OTHER;
    }
    return type;
}
//# sourceMappingURL=queryParser.js.map