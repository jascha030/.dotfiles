"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const arrays_1 = require("./arrays");
function mixin(destination, source) {
    if (!isObject(destination)) {
        return source;
    }
    if (isObject(source)) {
        Object.keys(source).forEach(key => {
            if (key in destination) {
                if (isObject(destination[key]) && isObject(source[key])) {
                    mixin(destination[key], source[key]);
                }
                else if (Array.isArray(destination[key]) && Array.isArray(source[key])) {
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
function isObject(obj) {
    return typeof obj === "object"
        && obj !== null
        && !Array.isArray(obj)
        && !(obj instanceof RegExp)
        && !(obj instanceof Date);
}
exports.isObject = isObject;
//# sourceMappingURL=objects.js.map