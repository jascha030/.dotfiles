"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class MatchMap {
    constructor(matcher, obj) {
        this.matcher = matcher;
        this.map = new Map();
        if (obj) {
            for (let key in obj) {
                this.set(key, obj[key]);
            }
        }
    }
    set(key, value) {
        this.map.set(key, value);
    }
    get(str) {
        let values = [];
        this.map.forEach((value, key) => {
            if (this.matcher.match(key, str))
                values.push(value);
        });
        return values;
    }
    keys() {
        return this.map.keys();
    }
    values() {
        return this.map.values();
    }
    size() {
        return this.map.size;
    }
    clear() {
        this.map.clear();
    }
}
exports.MatchMap = MatchMap;
//# sourceMappingURL=matchMap.js.map