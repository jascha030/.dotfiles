"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const block_1 = require("../block");
const doc_1 = require("../doc");
const config_1 = require("../util/config");
/**
 * Represents a class block
 */
class Class extends block_1.Block {
    constructor() {
        super(...arguments);
        /**
         * @inheritdoc
         */
        this.pattern = /^\s*(abstract|final)?\s*(class|trait|interface)\s+([A-Za-z0-9_]+)\s*/;
    }
    /**
     * @inheritdoc
     */
    parse() {
        let params = this.match();
        let doc = new doc_1.Doc('Undocumented ' + params[2]);
        doc.template = config_1.default.instance.get('classTemplate');
        return doc;
    }
}
exports.default = Class;
//# sourceMappingURL=class.js.map