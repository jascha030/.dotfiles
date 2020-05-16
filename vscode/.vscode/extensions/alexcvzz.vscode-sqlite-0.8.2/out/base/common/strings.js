"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// variables are identified with ${[variable name]}
function replaceVariableWithValue(str, values, ignoreCase = true) {
    str = str.replace(/\$\{(\w+)\}/g, (substr, ...args) => {
        let capture = args[0];
        if (ignoreCase)
            capture = capture.toLowerCase();
        return (values[capture] !== undefined && values[capture] !== null) ? values[capture].toString() : "";
    });
    return str;
}
exports.replaceVariableWithValue = replaceVariableWithValue;
function createFormattableString(str) {
    return {
        format(values, ignoreCase = true) {
            str = str.replace(/\$\{(\w+)\}/g, (substr, ...args) => {
                let capture = args[0];
                if (ignoreCase)
                    capture = capture.toLowerCase();
                return (values[capture] !== undefined && values[capture] !== null) ? values[capture].toString() : "";
            });
            return str;
        }
    };
}
exports.createFormattableString = createFormattableString;
function normalizeString(strOrArr, trim = true, toLowerCase = true, removeEmpty = true) {
    if (typeof strOrArr === "string") {
        let str = strOrArr;
        str = str.normalize().trim().toLowerCase();
        if (trim)
            str = str.trim();
        if (toLowerCase)
            str = str.toLowerCase();
        return str;
    }
    else {
        let strArr = strOrArr;
        strArr = strArr.map(str => normalizeString(str, trim, toLowerCase));
        if (removeEmpty)
            strArr = strArr.filter(str => str !== "");
        return strArr;
    }
}
exports.normalizeString = normalizeString;
function randomString(length, extended = false) {
    let text = "";
    let possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    if (extended)
        possible += "èé+*][ò@à#°ù§-_!£$%&/()=<>^ì?";
    for (var i = 0; i < length; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}
exports.randomString = randomString;
/**
 * Sanitizes a string for html
 */
function sanitizeStringForHtml(str) {
    let map = {
        '&': "&amp;",
        '<': "&lt;",
        '>': "&gt;",
        '/': "&#x2F;",
        '"': "&quot;",
        '\'': "&#039;"
    };
    return str.replace(/[&<>\/"']/g, m => map[m]);
}
exports.sanitizeStringForHtml = sanitizeStringForHtml;
//# sourceMappingURL=strings.js.map