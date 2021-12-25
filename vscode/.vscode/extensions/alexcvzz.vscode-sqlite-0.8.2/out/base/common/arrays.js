"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const types_1 = require("./types");
/**
 * Merge two arrays.
 * @param allowDuplicates If this is `true` the returned array is the concatenation of the two arrays passed as argument,
 * otherwise, duplicate items (objects, arrays, others) are ignored. Defaults to `false`
 */
function merge(arrA, arrB, allowDuplicates = false) {
    if (arrA.length === 0)
        return arrB;
    if (arrB.length === 0)
        return arrA;
    if (allowDuplicates)
        return arrA.concat(arrB);
    let arr = [];
    let joined = [...arrA, ...arrB];
    for (let elemJoined of joined) {
        let duplicate = false;
        for (let elemArr of arr) {
            if (types_1.isObject(elemJoined, false) && types_1.isObject(elemArr, false)) {
                if (JSON.stringify(elemJoined) === JSON.stringify(elemArr)) {
                    duplicate = true;
                    break;
                }
            }
            else {
                if (elemJoined === elemArr) {
                    duplicate = true;
                    break;
                }
            }
        }
        if (!duplicate) {
            arr.push(elemJoined);
        }
    }
    return arr;
}
exports.merge = merge;
function includes(arr, item) {
    return (arr.indexOf(item) > -1);
}
exports.includes = includes;
//# sourceMappingURL=arrays.js.map