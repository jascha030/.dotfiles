"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const util_1 = require("util");
// merges two arrays
function merge(arrA, arrB, duplicates = false) {
    if (arrA.length === 0)
        return arrB;
    if (arrB.length === 0)
        return arrA;
    if (duplicates)
        return arrA.concat(arrB);
    let arr = [];
    let joined = [...arrA, ...arrB];
    for (let elemJoined of joined) {
        let duplicate = false;
        for (let elemArr of arr) {
            if (util_1.isObject(elemJoined) && util_1.isObject(elemArr)) {
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
//# sourceMappingURL=arrays.js.map