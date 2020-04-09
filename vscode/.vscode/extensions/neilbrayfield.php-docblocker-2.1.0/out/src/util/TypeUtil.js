"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const config_1 = require("./config");
/**
 * Provides helper function to types
 */
class TypeUtil {
    /**
     * Returns the instance for this util
     *
     * @returns {TypeUtil}
     */
    static get instance() {
        return this._instance || (this._instance = new this());
    }
    /**
     * Get the full qualified class namespace for a type
     * we'll need to access the document
     *
     * @param {string} type
     * @param {string} head
     * @returns {string}
     */
    getFullyQualifiedType(type, head) {
        if (!config_1.default.instance.get('qualifyClassNames')) {
            return type;
        }
        let useEx = new RegExp("use\\s+([^ ]*?)((?:\\s+as\\s+))?(" + type + ");", 'gm');
        let full = useEx.exec(head);
        if (full != null && full[3] == type) {
            if (full[1].charAt(0) != '\\') {
                full[1] = '\\' + full[1];
            }
            if (full[2] != null) {
                return full[1];
            }
            return full[1] + type;
        }
        return type;
    }
    /**
     * Returns the user configuration based name for the given type
     *
     * @param {string} name
     */
    getFormattedTypeByName(name) {
        switch (name) {
            case 'bool':
            case 'boolean':
                if (!config_1.default.instance.get('useShortNames')) {
                    return 'boolean';
                }
                return 'bool';
            case 'int':
            case 'integer':
                if (!config_1.default.instance.get('useShortNames')) {
                    return 'integer';
                }
                return 'int';
            default:
                return name;
        }
    }
}
exports.default = TypeUtil;
//# sourceMappingURL=TypeUtil.js.map