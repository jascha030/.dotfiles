"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function match(glob, strOrArr, noGlobStar = true) {
    if (typeof strOrArr === "string") {
        //let str = strOrArr as string;
        return true;
    }
    else {
        //let strArr = strOrArr as string[];
        return [];
    }
}
exports.match = match;
//# sourceMappingURL=globs.js.map