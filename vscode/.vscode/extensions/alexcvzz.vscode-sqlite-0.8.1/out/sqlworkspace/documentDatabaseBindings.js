"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/**
 *
 */
class DocumentDatabaseBindings {
    constructor() {
        this.bindings = {};
    }
    bind(document, dbPath) {
        if (document) {
            this.bindings[document.uri.toString()] = dbPath;
            return true;
        }
        return false;
    }
    get(document) {
        if (document) {
            return this.bindings[document.uri.toString()];
        }
        else {
            return undefined;
        }
    }
    unbind(dbPath) {
        Object.keys(this.bindings).forEach((docId) => {
            if (this.bindings[docId] === dbPath) {
                delete this.bindings[docId];
            }
        });
    }
    dispose() {
        //
    }
}
exports.DocumentDatabaseBindings = DocumentDatabaseBindings;
//# sourceMappingURL=documentDatabaseBindings.js.map