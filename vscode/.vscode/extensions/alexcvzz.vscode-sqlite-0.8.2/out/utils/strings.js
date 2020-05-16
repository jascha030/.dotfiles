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
function normalize(strOrArr) {
    if (typeof strOrArr === "string") {
        let str = strOrArr;
        return str.trim().toLowerCase();
    }
    else {
        let strArr = strOrArr;
        return strArr.map(str => str.trim().toLowerCase()).filter(str => str != "");
    }
}
exports.normalize = normalize;
//# sourceMappingURL=strings.js.map