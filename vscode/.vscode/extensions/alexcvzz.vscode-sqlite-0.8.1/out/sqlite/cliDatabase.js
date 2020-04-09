"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const child_process_1 = require("child_process");
const os_1 = require("os");
const utils_1 = require("../utils/utils");
const csvparser = require("csv-parser");
const NO_HANDLER = (...args) => { }; // this is just an empty function to handle callbacks i dont care about
const RESULT_SEPARATOR = utils_1.randomString(8); // just a random separator to recognize when there are no more rows
class CliDatabase {
    constructor(command, path, callback) {
        this.command = command;
        this.path = path;
        let args = ["-csv", "-header", "-bail", "-nullvalue", "NULL"];
        this._started = false;
        this._ended = false;
        this.errStr = "";
        this.rows = [];
        this.execQueue = [];
        this.busy = false;
        this.startCallback = callback;
        this.csvParser = csvparser({ separator: ',', strict: false, headers: false });
        try {
            this.sqliteProcess = child_process_1.spawn(this.command, args, { stdio: ['pipe', "pipe", "pipe"] });
        }
        catch (err) {
            let startError = new Error("Database failed to open: SQLite process failed to start: " + err.message);
            setTimeout(() => this.onStartError(startError), 0);
            return;
        }
        this.sqliteProcess.once('error', (err) => {
            let startError = new Error("Database failed to open: SQLite process failed to start: " + err.message);
            this.onStartError(startError);
        });
        try {
            this._write(`.open '${this.path}'${os_1.EOL}`);
            this._write(`select 1 from sqlite_master;${os_1.EOL}`);
            this._write(`.print ${RESULT_SEPARATOR}${os_1.EOL}`);
            this.busy = true;
        }
        catch (err) {
            let startError = new Error(`Database failed to open: '${this.path}'`);
            setTimeout(() => this.onStartError(startError), 0);
            return;
        }
        this.sqliteProcess.once('exit', (code, signal) => {
            this.onExit(code, signal);
        });
        this.sqliteProcess.stderr.on("data", (data) => {
            this.onError(data);
        });
        this.sqliteProcess.stdout.pipe(this.csvParser).on("data", (data) => {
            this.onData(data);
        });
        // register an empty handler for stdio,
        // we dont care about errors,
        // they will only occur when the process stops because of -bail
        this.sqliteProcess.stdin.once("error", NO_HANDLER);
        this.sqliteProcess.stdout.once("error", NO_HANDLER);
        this.sqliteProcess.stderr.once("error", NO_HANDLER);
        this.csvParser.once("error", NO_HANDLER);
    }
    close(callback) {
        if (this._ended) {
            if (callback)
                callback(new Error("Database is closed: SQLite process already ended."));
            return;
        }
        try {
            this._ended = true;
            this.endCallback = callback;
            this.execQueue.push({ sql: ".exit" });
            if (!this.busy) {
                this.next();
            }
        }
        catch (err) {
            //
        }
    }
    execute(sql, callback) {
        if (this._ended) {
            if (callback)
                callback([], new Error("Database is closed: SQLite process already ended."));
            return;
        }
        // trim the sql
        sql = sql.trim();
        // ignore if it's a dot command
        if (sql.startsWith(".")) {
            return;
        }
        // add a space after EXPLAIN so that the result is a table (see: https://www.sqlite.org/eqp.html)
        if (sql.toLowerCase().startsWith("explain")) {
            let pos = "explain".length;
            sql = sql.slice(0, pos) + " " + sql.slice(pos);
        }
        try {
            this.execQueue.push({ sql: sql, callback: callback });
            if (!this.busy) {
                this.next();
            }
        }
        catch (err) {
            //
        }
    }
    _write(text) {
        if (!this.sqliteProcess)
            return;
        // add EOL at the end
        if (!text.endsWith("\n"))
            text += "\n";
        try {
            this.sqliteProcess.stdin.write(text);
        }
        catch (err) {
            //
        }
    }
    onStartError(err) {
        this._started = false;
        this.csvParser.end();
        if (this.startCallback) {
            this.startCallback(err);
            this.startCallback = undefined;
        }
    }
    onExit(code, signal) {
        this._ended = true;
        this.csvParser.end();
        if (!this._started) {
            if (this.startCallback)
                this.startCallback(new Error(`Database failed to open: '${this.path}'`));
            return;
        }
        if (code === 0) {
            //
        }
        else if (code === 1 || signal) {
            if (this.writeCallback)
                this.writeCallback([], new Error(this.errStr));
        }
        if (this.endCallback)
            this.endCallback();
    }
    onData(data) {
        if (this.errStr) {
            return;
        }
        //@ts-ignore
        let row = Object.values(data);
        if (row.length === 1 && row[0] === RESULT_SEPARATOR) {
            if (!this._started) {
                this._started = true;
            }
            if (this.writeCallback)
                this.writeCallback(this.rows);
            this.next();
            return;
        }
        this.rows.push(row);
    }
    onError(data) {
        if (!data)
            return;
        // Workaround for CentOS (and maybe other OS's) where the command throws an error at the start but everything works fine
        if (data.toString().match(/\: \/lib64\/libtinfo\.so\.[0-9]+: no version information available \(required by /))
            return;
        this.errStr += data.toString();
        // last part of the error output
        if (this.errStr.endsWith("\n")) {
            // reformat the error message
            let match = this.errStr.match(/Error: near line [0-9]+:(?: near "(.+)":)? (.+)/);
            if (match) {
                let token = match[1];
                let rest = match[2];
                this.errStr = `${token ? `near "${token}": ` : ``}${rest}`;
            }
            //if (this.sqliteProcess) this.sqliteProcess.kill();
        }
    }
    next() {
        this.rows = [];
        let execObj = this.execQueue.shift();
        if (execObj) {
            this._write(execObj.sql);
            this._write(`.print ${RESULT_SEPARATOR}${os_1.EOL}`);
            this.busy = true;
            this.writeCallback = execObj.callback;
        }
        else {
            this.busy = false;
        }
    }
    get ended() {
        return this._ended;
    }
    get started() {
        return this._started;
    }
}
exports.CliDatabase = CliDatabase;
//# sourceMappingURL=cliDatabase.js.map