"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const config_1 = require("./util/config");
/**
 * Represents a comment block.
 *
 * This class collects data about the snippet then builds
 * it with the appropriate tags
 */
class Doc {
    /**
     * Creates an instance of Doc.
     *
     * @param {string} [message='']
     */
    constructor(message = '') {
        /**
         * List of param tags
         *
         * @type {Array<Param>}
         */
        this.params = [];
        this.message = message;
    }
    /**
     * Set class properties from a standard object
     *
     * @param {*} input
     */
    fromObject(input) {
        if (input.return !== undefined) {
            this.return = input.return;
        }
        if (input.var !== undefined) {
            this.var = input.var;
        }
        if (input.message !== undefined) {
            this.message = input.message;
        }
        if (input.params !== undefined && Array.isArray(input.params)) {
            input.params.forEach(param => {
                this.params.push(new Param(param.type, param.name));
            });
        }
    }
    /**
     * Build all the set values into a SnippetString ready for use
     *
     * @param {boolean} [isEmpty=false]
     * @returns {SnippetString}
     */
    build(isEmpty = false) {
        let extra = config_1.default.instance.get('extra');
        let gap = config_1.default.instance.get('gap');
        let returnGap = config_1.default.instance.get('returnGap');
        let returnString = "";
        let varString = "";
        let paramString = "";
        let extraString = "";
        let messageString = "";
        if (isEmpty) {
            gap = true;
            extra = [];
        }
        messageString = "\${###" + (this.message != "" ? ':' : '') + this.message + "}";
        if (this.params.length) {
            paramString = "";
            this.params.forEach(param => {
                if (paramString != "") {
                    paramString += "\n";
                }
                paramString += "@param \${###:" + param.type + "} " + param.name.replace('$', '\\$');
            });
        }
        if (this.var) {
            varString = "@var \${###:" + this.var + "}";
        }
        if (this.return && (this.return != 'void' || config_1.default.instance.get('returnVoid'))) {
            returnString = "@return \${###:" + this.return + "}";
        }
        if (Array.isArray(extra) && extra.length > 0) {
            extraString = extra.join("\n");
        }
        let templateArray = [];
        for (let key in this.template) {
            let propConfig = this.template[key];
            let propString;
            if (key == 'message' && messageString) {
                propString = messageString;
                if (gap) {
                    propConfig.gapAfter = true;
                }
            }
            else if (key == 'var' && varString) {
                propString = varString;
            }
            else if (key == 'return' && returnString) {
                propString = returnString;
                if (returnGap) {
                    propConfig.gapBefore = true;
                }
            }
            else if (key == 'param' && paramString) {
                propString = paramString;
            }
            else if (key == 'extra' && extraString) {
                propString = extraString;
            }
            else if (propConfig.content !== undefined) {
                propString = propConfig.content;
            }
            if (propString && propConfig.gapBefore && templateArray[templateArray.length - 1] != "") {
                templateArray.push("");
            }
            if (propString) {
                templateArray.push(propString);
            }
            if (propString && propConfig.gapAfter) {
                templateArray.push("");
            }
        }
        if (templateArray[templateArray.length - 1] == "") {
            templateArray.pop();
        }
        let templateString = templateArray.join("\n");
        templateString = "/**\n" + templateString + "\n */";
        let stop = 0;
        templateString = templateString.replace(/###/gm, function () {
            stop++;
            return stop + "";
        });
        templateString = templateString.replace(/^$/gm, " *");
        templateString = templateString.replace(/^(?!(\s\*|\/\*))/gm, " * $1");
        let snippet = new vscode_1.SnippetString(templateString);
        return snippet;
    }
    /**
     * Set the template for rendering
     *
     * @param {Object} template
     */
    set template(template) {
        this._template = template;
    }
    /**
     * Get the template
     *
     * @type {Object}
     */
    get template() {
        if (this._template == null) {
            return {
                message: {},
                var: {},
                param: {},
                return: {},
                extra: {}
            };
        }
        return this._template;
    }
}
exports.Doc = Doc;
/**
 * A simple paramter object
 */
class Param {
    /**
     * Creates an instance of Param.
     *
     * @param {string} type
     * @param {string} name
     */
    constructor(type, name) {
        this.type = type;
        this.name = name;
    }
}
exports.Param = Param;
//# sourceMappingURL=doc.js.map