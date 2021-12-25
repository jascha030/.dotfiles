"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function match(glob, strOrArr, noGlobStar = true) {
    if (typeof strOrArr === "string") {
        let str = strOrArr;
        return true;
    }
    else {
        let strArr = strOrArr;
        return [];
    }
}
exports.match = match;
//# sourceMappingURL=globs.js.map