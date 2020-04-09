"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const block_1 = require("../block");
const doc_1 = require("../doc");
const TypeUtil_1 = require("../util/TypeUtil");
const config_1 = require("../util/config");
/**
 * Represents a function code block
 *
 * This is probably going to be the most complicated of all the
 * blocks as function signatures tend to be the most complex and
 * varied
 */
class FunctionBlock extends block_1.Block {
    constructor() {
        super(...arguments);
        /**
         * @inheritdoc
         */
        this.pattern = /^\s*((.*)(protected|private|public))?(.*)?\s*function\s+&?([A-Za-z0-9_]+)\s*\(([^{;]*)/m;
    }
    /**
     * @inheritdoc
     */
    parse() {
        let params = this.match();
        let doc = new doc_1.Doc('Undocumented function');
        doc.template = config_1.default.instance.get('functionTemplate');
        let argString = this.getEnclosed(params[6], "(", ")");
        let head;
        if (argString != "") {
            let args = argString.split(',');
            if (config_1.default.instance.get('qualifyClassNames')) {
                head = this.getClassHead();
            }
            for (let index = 0; index < args.length; index++) {
                let arg = args[index];
                let parts = arg.match(/^\s*(\?)?\s*([A-Za-z0-9_\\]+)?\s*\&?((?:[.]{3})?\$[A-Za-z0-9_]+)\s*\=?\s*(.*)\s*/m);
                var type = '[type]';
                if (parts[2] != null) {
                    parts[2] = TypeUtil_1.default.instance.getFullyQualifiedType(parts[2], head);
                }
                if (parts[2] != null && parts[1] === '?') {
                    type = TypeUtil_1.default.instance.getFormattedTypeByName(parts[2]) + '|null';
                }
                else if (parts[2] != null) {
                    type = TypeUtil_1.default.instance.getFormattedTypeByName(parts[2]);
                }
                else if (parts[4] != null && parts[4] != "") {
                    type = TypeUtil_1.default.instance.getFormattedTypeByName(this.getTypeFromValue(parts[4]));
                }
                doc.params.push(new doc_1.Param(type, parts[3]));
            }
        }
        let returnType = this.signature.match(/.*\)\s*\:\s*(\?)?\s*([a-zA-Z_0-9\\]+)\s*$/m);
        if (returnType != null) {
            if (config_1.default.instance.get('qualifyClassNames')) {
                returnType[2] = TypeUtil_1.default.instance.getFullyQualifiedType(returnType[2], this.getClassHead());
            }
            doc.return = (returnType[1] === '?')
                ? TypeUtil_1.default.instance.getFormattedTypeByName(returnType[2]) + '|null'
                : TypeUtil_1.default.instance.getFormattedTypeByName(returnType[2]);
        }
        else {
            doc.return = this.getReturnFromName(params[5]);
        }
        return doc;
    }
    /**
     * We can usually assume that these function names will
     * be certain return types and we can save ourselves some
     * effort by checking these
     *
     * @param {string} name
     * @returns {string}
     */
    getReturnFromName(name) {
        if (/^(is|has|can|should)(?:[A-Z0-9_]|$)/.test(name)) {
            return TypeUtil_1.default.instance.getFormattedTypeByName('bool');
        }
        switch (name) {
            case '__construct':
            case '__destruct':
            case '__set':
            case '__unset':
            case '__wakeup':
                return null;
            case '__isset':
                return TypeUtil_1.default.instance.getFormattedTypeByName('bool');
            case '__sleep':
            case '__debugInfo':
                return 'array';
            case '__toString':
                return 'string';
        }
        return 'void';
    }
}
exports.default = FunctionBlock;
//# sourceMappingURL=function.js.map