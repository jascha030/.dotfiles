"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const customview_1 = require("./customview");
const utils_1 = require("../utils/utils");
const csvStringify = require("csv-stringify/lib/sync");
const path_1 = require("path");
const os_1 = require("os");
class ResultView extends customview_1.CustomView {
    constructor(extensionPath) {
        super('resultview', 'SQLite');
        this.extensionPath = extensionPath;
        this.msgQueue = [];
        this.recordsPerPage = 50;
    }
    display(resultSet, recordsPerPage) {
        this.show(path_1.join(this.extensionPath, 'out', 'resultview', 'htmlcontent', 'index.html'));
        this.recordsPerPage = recordsPerPage;
        this.resultSet = undefined;
        this.msgQueue = [];
        if (Array.isArray(resultSet)) {
            this.resultSet = resultSet;
        }
        else {
            resultSet.then(rs => {
                this.resultSet = rs ? rs : [];
                //if (this.resultSet) {
                if (this.msgQueue)
                    this.msgQueue.forEach(this.handleMessage.bind(this));
                //} else {
                //this.dispose();
                //}
            });
        }
    }
    handleMessage(message) {
        let cmdType = message.command.split(':')[0];
        let cmdRest = message.command.split(':')[1];
        if (this.resultSet) {
            let obj;
            switch (cmdType) {
                case 'fetch':
                    obj = this.fetch(cmdRest);
                    if (obj != null)
                        this.send({ command: message.command, data: obj, id: message.id });
                    break;
                case 'csv':
                    obj = this.fetch(cmdRest);
                    if (obj != null)
                        this.exportCsv(obj);
                    break;
                case 'json':
                    obj = this.fetch(cmdRest);
                    if (obj != null)
                        this.exportJson(obj);
                    break;
                case 'html':
                    obj = this.fetch(cmdRest);
                    if (obj != null)
                        this.exportHtml(obj);
                    break;
                default:
                    break;
            }
        }
        else {
            this.msgQueue.push(message);
        }
    }
    fetch(resource) {
        return utils_1.queryObject({ resultSet: this.resultSet, pageRows: this.recordsPerPage }, resource);
    }
    exportJson(obj) {
        let content = JSON.stringify(obj);
        this.exportFile('json', content);
    }
    exportCsv(obj) {
        // setTimeout is just to make this async
        setTimeout(() => {
            let csvList = [];
            if (Array.isArray(obj)) {
                for (let i in obj) {
                    let ret = csvStringify(obj[i].rows, { columns: obj[i].header, header: true });
                    csvList.push(ret);
                }
            }
            else {
                let ret = csvStringify(obj.rows, { columns: obj.header, header: true });
                csvList.push(ret);
            }
            this.exportFile('csv', csvList.join(os_1.EOL));
        }, 0);
    }
    exportHtml(obj) {
        let toHtml = (header, rows) => {
            let str = "<table>";
            str += "<tr>" + header.map(val => `<th>${utils_1.sanitizeStringForHtml(val)}</th>`).join("") + "<tr>";
            str += rows.map(row => `<tr>${row.map(val => `<td>${utils_1.sanitizeStringForHtml(val)}</td>`).join("")}</tr>`).join("");
            str += "</table>";
            return str;
        };
        setTimeout(() => {
            let htmlList = [];
            if (Array.isArray(obj)) {
                for (let i in obj) {
                    let ret = toHtml(obj[i].header, obj[i].rows);
                    htmlList.push(ret);
                }
            }
            else {
                let ret = toHtml(obj.header, obj.rows);
                htmlList.push(ret);
            }
            this.exportFile('html', htmlList.join(""));
        }, 0);
    }
    exportFile(language, content) {
        vscode_1.workspace.openTextDocument({ language: language, content: content })
            .then(doc => vscode_1.window.showTextDocument(doc, vscode_1.ViewColumn.One))
            .then(() => vscode_1.commands.executeCommand('workbench.action.files.saveAs'));
    }
}
exports.default = ResultView;
//# sourceMappingURL=index.js.map