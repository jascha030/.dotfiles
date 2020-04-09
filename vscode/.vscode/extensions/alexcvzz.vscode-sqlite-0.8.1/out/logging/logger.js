"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const constants_1 = require("../constants/constants");
var Level;
(function (Level) {
    Level["DEBUG"] = "DEBUG";
    Level["INFO"] = "INFO";
    Level["WARN"] = "WARN";
    Level["ERROR"] = "ERROR";
})(Level = exports.Level || (exports.Level = {}));
class Logger {
    constructor() {
        this.logLevel = Level.INFO;
        this.outputChannel = vscode_1.window.createOutputChannel(`${constants_1.Constants.outputChannelName}`);
    }
    setLogLevel(logLevel) {
        this.logLevel = logLevel;
    }
    debug(msg) {
        this.log(`${msg.toString()}`, Level.DEBUG);
    }
    info(msg) {
        this.log(`${msg.toString()}`, Level.INFO);
    }
    warn(msg) {
        this.log(`${msg.toString()}`, Level.WARN);
    }
    error(msg) {
        this.log(`${msg.toString()}`, Level.ERROR);
    }
    output(msg) {
        this.outputChannel.appendLine(msg.toString());
    }
    showOutput() {
        this.outputChannel.show();
    }
    getOutputChannel() {
        return this.outputChannel;
    }
    log(msg, level) {
        const time = new Date().toLocaleTimeString();
        msg = `[${time}][${constants_1.Constants.extensionName}][${level}] ${msg}`;
        switch (level) {
            case Level.ERROR:
                console.error(msg);
                break;
            case Level.WARN:
                console.warn(msg);
                break;
            case Level.INFO:
                console.info(msg);
                break;
            default:
                console.log(msg);
                break;
        }
        // log to output channel
        if (this.logLevel && logLevelGreaterThan(level, this.logLevel)) {
            this.output(msg);
        }
    }
}
/**
 * Verify if log level l1 is greater than log level l2
 * DEBUG < INFO < WARN < ERROR
 */
function logLevelGreaterThan(l1, l2) {
    switch (l2) {
        case Level.ERROR:
            return (l1 === Level.ERROR);
        case Level.WARN:
            return (l1 === Level.WARN || l1 === Level.ERROR);
        case Level.INFO:
            return (l1 === Level.INFO || l1 === Level.WARN || l1 === Level.ERROR);
        case Level.DEBUG:
            return true;
        default:
            return (l1 === Level.INFO || l1 === Level.WARN || l1 === Level.ERROR);
    }
}
exports.logger = new Logger();
//# sourceMappingURL=logger.js.map