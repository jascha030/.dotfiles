"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = require("fs");
function isDirectorySync(filePath) {
    try {
        var stat = fs_1.lstatSync(filePath);
        return stat.isDirectory();
    }
    catch (e) {
        // lstatSync throws an error if path doesn't exist
        return false;
    }
}
exports.isDirectorySync = isDirectorySync;
function isFileSync(filePath) {
    try {
        var stat = fs_1.lstatSync(filePath);
        return stat.isFile();
    }
    catch (e) {
        // lstatSync throws an error if path doesn't exist
        return false;
    }
}
exports.isFileSync = isFileSync;
function fileExists(filePath) {
    return new Promise((resolve, reject) => {
        fs_1.exists(filePath, (exists) => {
            resolve(exists);
        });
    });
}
exports.fileExists = fileExists;
function fileExistsSync(filePath) {
    return fs_1.existsSync(filePath);
}
exports.fileExistsSync = fileExistsSync;
//# sourceMappingURL=files.js.map