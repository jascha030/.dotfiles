"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const jsonschema_1 = require("jsonschema");
const objects_1 = require("../common/objects");
const types_1 = require("../common/types");
function validateObject(obj, schema, replaceWrongProperties = false) {
    let ret = jsonschema_1.validate(obj, schema);
    if (replaceWrongProperties) {
        for (let error of ret.errors) {
            let defVal = undefined;
            if (types_1.isString(error.schema)) {
                defVal = JSON.parse(error.schema).default;
            }
            else {
                defVal = error.schema.default;
            }
            if (defVal) {
                objects_1.replaceProperty(obj, error.property, defVal);
            }
        }
    }
    return ret.valid;
}
exports.validateObject = validateObject;
//# sourceMappingURL=jsonschema.js.map