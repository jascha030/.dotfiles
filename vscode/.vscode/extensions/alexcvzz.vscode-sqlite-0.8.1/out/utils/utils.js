"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
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
function replaceEscapedOctetsWithChar(s) {
    return s.replace(/(?:^|[^\\])((?:\\[0-9]{3})+)/g, (substring, ...args) => {
        let capgroup = args[0].toString();
        let prevChar = '';
        if (substring.length > capgroup.length) {
            prevChar = substring[0];
        }
        let octal = capgroup.split('\\').filter(s => s.trim() !== "");
        try {
            let chars = octalToChars(octal);
            return prevChar + chars;
        }
        catch (err) {
            return substring;
        }
    });
}
exports.replaceEscapedOctetsWithChar = replaceEscapedOctetsWithChar;
function octalToChars(octal) {
    let hex = octal.map(octet => convertFromBaseToBase(octet, 8, 16)).join('');
    let s = new Buffer(hex, 'hex').toString('utf8');
    for (let i = 0; i < s.length; i++) {
        if (s.charCodeAt(i) === 65533) {
            // the character is an uncknown character, this is probably binary data
            return hex;
        }
    }
    return s;
}
exports.octalToChars = octalToChars;
function convertFromBaseToBase(str, fromBase, toBase) {
    if (typeof (str) === 'number') {
        str = str.toString();
    }
    var num = parseInt(str, fromBase);
    return num.toString(toBase);
}
exports.convertFromBaseToBase = convertFromBaseToBase;
function splitArrayByCondition(arr, cond) {
    let newArr = [];
    arr.forEach(elem => {
        if (cond(elem) || newArr === []) {
            newArr.push([elem]);
        }
        else {
            newArr[newArr.length - 1].push(elem);
        }
    });
    return newArr;
}
exports.splitArrayByCondition = splitArrayByCondition;
function findNotInString(character, str) {
    let charArray = Array.from(str);
    let isInString = false;
    let stringChar = null;
    let found = [];
    for (let index = 0; index < charArray.length; index++) {
        let char = charArray[index];
        let prev = index > 0 ? charArray[index - 1] : null;
        let next = index < charArray.length ? charArray[index + 1] : null;
        // it's in string, go to next char
        if (prev !== '\\' && (char === '\'' || char === '"') && isInString === false) {
            isInString = true;
            stringChar = char;
            continue;
        }
        // string closed, go to next char
        if (prev !== '\\' && char === stringChar && isInString === true) {
            isInString = false;
            stringChar = null;
            continue;
        }
        if ((character.length === 1 ? char === character : char === character[0] && next === character[1]) && isInString === false) {
            found.push(index);
            continue;
        }
    }
    return found;
}
exports.findNotInString = findNotInString;
function splitNotInString(char, str) {
    let idxs = findNotInString(char, str);
    let substrs = [];
    idxs.forEach((idx, i) => {
        let start = i > 0 ? idxs[i - 1] + char.length : 0;
        let substr = str.substring(start, idx);
        substrs.push(substr);
    });
    substrs.push(str.substring(idxs === [] ? 0 : idxs[idxs.length - 1] + char.length));
    return substrs;
}
exports.splitNotInString = splitNotInString;
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
function uniqueBy(arr, prop) {
    var seen = {};
    return arr.filter((item) => {
        let k = item[prop];
        return k && seen.hasOwnProperty(k) ? false : (seen[k] = true);
    });
}
exports.uniqueBy = uniqueBy;
//# sourceMappingURL=utils.js.map