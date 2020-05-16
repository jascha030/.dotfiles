"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function removeCaptures(regExStr) {
    return regExStr.replace(/[^\\]\((?!\?\:)/g, substr => {
        return substr + "?:";
    });
}
exports.removeCaptures = removeCaptures;
function findMatches(regex, str, strOffset = 0, matches = []) {
    let execArr = regex.exec(str);
    if (execArr) {
        matches.push({ match: execArr[0], groups: execArr.slice(1), index: execArr.index + strOffset, length: execArr[0].length });
        let offset = execArr.index + execArr[0].length;
        findMatches(regex, str.substring(offset), strOffset + offset, matches);
    }
    return matches;
}
exports.findMatches = findMatches;
//# sourceMappingURL=regex.js.map