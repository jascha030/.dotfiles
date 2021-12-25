"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class ObjMap {
    constructor() {
        this.map = {};
    }
    set(key, value) {
        this.map[JSON.stringify(key)] = value;
    }
    get(key) {
        return this.map[JSON.stringify(key)];
    }
}
exports.ObjMap = ObjMap;
//# sourceMappingURL=objMap.js.map