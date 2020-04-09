"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const keywords_1 = require("./keywords");
const utils_1 = require("../utils/utils");
class CompletionProvider {
    constructor(schemaProvider) {
        this.schemaProvider = schemaProvider;
        this.schemaMap = {};
    }
    provideCompletionItems(document, position, token, context) {
        let schema = this.schemaMap[document.uri.fsPath];
        let promise = schema ? Promise.resolve(schema) : this.schemaProvider.provideSchema(document);
        return promise.then(schema => {
            if (!schema)
                return this.getKeywordCompletionItems(keywords_1.keywords);
            let items = [];
            if (context.triggerCharacter === '.') {
                // when the trigger character is a dot we assume that we just need the columns
                let range = document.getWordRangeAtPosition(position.translate(0, -1));
                let tableName = document.getText(range);
                let table = schema ? schema.tables.find(tbl => tbl.name === tableName) : undefined;
                if (table) {
                    items = this.getColumnCompletionItems(table.columns);
                }
                else {
                    items = this.getColumnCompletionItems(schema.tables.reduce((acc, tbl) => acc.concat(tbl.columns), []));
                }
                return items;
            }
            let keywordItems = this.getKeywordCompletionItems(keywords_1.keywords);
            let tableItems = this.getTableCompletionsItems(schema.tables);
            let columnItems = this.getColumnCompletionItems(schema.tables.reduce((acc, tbl) => acc.concat(tbl.columns), []));
            return [...tableItems, ...columnItems, ...keywordItems];
        });
    }
    getTableCompletionsItems(tables = []) {
        let tableItems = tables.map(tbl => new TableCompletionItem(tbl.name));
        return tableItems;
    }
    getColumnCompletionItems(columns = [], noDuplicates = true) {
        let columnItems = columns.map(col => new ColumnCompletionItem(col.name));
        if (noDuplicates) {
            columnItems = utils_1.uniqueBy(columnItems, "label");
        }
        return columnItems;
    }
    getKeywordCompletionItems(keywords) {
        let items = keywords.map(word => new KeywordCompletionItem(word));
        return items;
    }
}
exports.CompletionProvider = CompletionProvider;
class KeywordCompletionItem extends vscode_1.CompletionItem {
    constructor(keyword) {
        super(keyword, vscode_1.CompletionItemKind.Keyword);
    }
}
class TableCompletionItem extends vscode_1.CompletionItem {
    constructor(name) {
        super(name, vscode_1.CompletionItemKind.File);
        this.detail = "table";
    }
}
class ColumnCompletionItem extends vscode_1.CompletionItem {
    constructor(name) {
        super(name, vscode_1.CompletionItemKind.Field);
        this.detail = "column";
    }
}
//# sourceMappingURL=completionProvider.js.map