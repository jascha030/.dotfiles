"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const child_process = require("child_process");
const streamParser_1 = require("./streamParser");
const resultSetParser_1 = require("./resultSetParser");
const os_1 = require("os");
function execute(sqliteCommand, dbPath, query, callback) {
    let resultSet;
    let errorMessage = "";
    let streamParser = new streamParser_1.StreamParser(new resultSetParser_1.ResultSetParser());
    let args = [
        //dbPath,
        `-header`,
        `-nullvalue`, `NULL`,
        //`-echo`, // print the statement before the result
        `-cmd`, `.mode tcl`
    ];
    let proc = child_process.spawn(sqliteCommand, args, { stdio: ['pipe', "pipe", "pipe"] });
    // these next lines are written in the stdin to avoid errors when using unicode characters (see issues #32, #37)
    proc.stdin.write(`.open '${dbPath}'${os_1.EOL}`);
    proc.stdin.write(`.echo on${os_1.EOL}`);
    proc.stdin.end(query);
    proc.stdout.pipe(streamParser).once('done', (data) => {
        resultSet = data;
    });
    proc.stderr.on('data', (data) => {
        errorMessage += data.toString().trim();
    });
    proc.once('error', (data) => {
        errorMessage += data;
    });
    proc.once('close', () => {
        let error = errorMessage ? Error(errorMessage) : undefined;
        callback(resultSet, error);
    });
}
exports.execute = execute;
//# sourceMappingURL=sqlite.js.map