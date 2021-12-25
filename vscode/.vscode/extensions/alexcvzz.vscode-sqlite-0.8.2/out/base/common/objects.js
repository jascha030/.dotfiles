"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const arrays_1 = require("./arrays");
const types_1 = require("./types");
/**
 * Recursively combine two objects.
 * Arrays are merged.
 * Primitive types (string, number, boolean ...) are substituted.
 */
function mixin(destination, source) {
    if (!types_1.isObject(destination)) {
        return source;
    }
    if (types_1.isObject(source)) {
        Object.keys(source).forEach(key => {
            if (key in destination) {
                if (types_1.isObject(destination[key]) && types_1.isObject(source[key])) {
                    mixin(destination[key], source[key]);
                }
                else if (types_1.isArray(destination[key]) && types_1.isArray(source[key])) {
                    destination[key] = arrays_1.merge(destination[key], source[key]);
                }
                else {
                    destination[key] = source[key];
                }
            }
            else {
                destination[key] = source[key];
            }
        });
    }
    return destination;
}
exports.mixin = mixin;
function queryObject(obj, query) {
    let ret = obj;
    let tokens = query.split('/').filter(tkn => tkn !== "");
    while (true) {
        let token = tokens.shift();
        if (token && ret) {
            ret = ret[token];
        }
        else {
            break;
        }
    }
    return ret;
}
exports.queryObject = queryObject;
//# sourceMappingURL=objects.js.map