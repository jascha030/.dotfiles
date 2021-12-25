"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const function_1 = require("./block/function");
const property_1 = require("./block/property");
const class_1 = require("./block/class");
const doc_1 = require("./doc");
/**
 * Check which type of docblock we need and instruct the components to build the
 * snippet and pass it back
 */
class Documenter {
    /**
     * Creates an instance of Documenter.
     *
     * @param {Range} range
     * @param {TextEditor} editor
     */
    constructor(range, editor) {
        this.targetPosition = range.start;
        this.editor = editor;
    }
    /**
     * Load and test each type of signature to see if they can trigger and
     * if not load an empty block
     *
     * @returns {SnippetString}
     */
    autoDocument() {
        let func = new function_1.default(this.targetPosition, this.editor);
        if (func.test()) {
            return func.parse().build();
        }
        let prop = new property_1.default(this.targetPosition, this.editor);
        if (prop.test()) {
            return prop.parse().build();
        }
        let cla = new class_1.default(this.targetPosition, this.editor);
        if (cla.test()) {
            return cla.parse().build();
        }
        return new doc_1.Doc().build(true);
    }
}
exports.default = Documenter;
//# sourceMappingURL=documenter.js.map