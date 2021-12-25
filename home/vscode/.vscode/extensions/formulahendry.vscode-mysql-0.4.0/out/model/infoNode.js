"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class InfoNode {
    constructor(label) {
        this.label = label;
    }
    getTreeItem() {
        return {
            label: this.label,
        };
    }
    getChildren() {
        return [];
    }
}
exports.InfoNode = InfoNode;
//# sourceMappingURL=infoNode.js.map