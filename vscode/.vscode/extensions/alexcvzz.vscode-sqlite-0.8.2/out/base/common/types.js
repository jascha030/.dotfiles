"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function isBoolean(obj) {
    return (obj === false || obj === true);
}
exports.isBoolean = isBoolean;
function isObject(obj, strict = true) {
    if (strict) {
        return typeof obj === "object"
            && obj !== null
            && !Array.isArray(obj)
            && !(obj instanceof RegExp)
            && !(obj instanceof Date);
    }
    else {
        return typeof obj === "object" && obj !== null;
    }
}
exports.isObject = isObject;
function isArray(obj) {
    return Array.isArray(obj)
        && obj !== null;
}
exports.isArray = isArray;
function isString(obj, minLength = 0, maxLength = Number.MAX_VALUE) {
    return (typeof obj === "string" &&
        obj.length >= minLength &&
        obj.length <= maxLength);
}
exports.isString = isString;
function isNumber(obj, min = Number.MIN_VALUE, max = Number.MAX_VALUE) {
    return (typeof obj === "number" &&
        obj >= min &&
        obj <= max);
}
exports.isNumber = isNumber;
//# sourceMappingURL=types.js.map