"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class MultiKeyMap {
    constructor() {
        this.map = {};
    }
    set(keys, value) {
        for (let key of keys) {
            this.map[key] = value;
        }
    }
    get(key) {
        return this.map[key];
    }
    delete(key) {
        delete this.map[key];
    }
    reset() {
        this.map = {};
    }
}
exports.MultiKeyMap = MultiKeyMap;
//# sourceMappingURL=multiKeyMap.js.map