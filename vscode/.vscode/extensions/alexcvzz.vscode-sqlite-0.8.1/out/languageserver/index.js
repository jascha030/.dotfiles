"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const completionProvider_1 = require("./completionProvider");
class LanguageServer {
    constructor() {
        this.subscriptions = [];
        this.completionProvider = new completionProvider_1.CompletionProvider({
            provideSchema: (doc) => {
                if (this.schemaHandler)
                    return this.schemaHandler(doc);
                else
                    return Promise.resolve();
            }
        });
        let documentSelector = [{ language: 'sql' }, { language: 'sqlite' }];
        this.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(documentSelector, this.completionProvider, '.'));
    }
    setSchemaHandler(schemaHandler) {
        this.schemaHandler = schemaHandler;
    }
    dispose() {
        vscode_1.Disposable.from(...this.subscriptions).dispose();
    }
}
exports.default = LanguageServer;
//# sourceMappingURL=index.js.map