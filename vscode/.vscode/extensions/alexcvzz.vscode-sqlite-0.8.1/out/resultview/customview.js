"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const path_1 = require("path");
const fs_1 = require("fs");
const utils_1 = require("../utils/utils");
const events_1 = require("events");
class CustomView extends events_1.EventEmitter {
    constructor(type, title) {
        super();
        this.type = type;
        this.title = title;
        this.resourceScheme = 'vscode-resource';
        this.resourcesPath = "";
        this.htmlCache = {};
    }
    show(htmlPath) {
        this.resourcesPath = path_1.dirname(htmlPath);
        if (!this.panel) {
            this.init();
        }
        this.readWithCache(htmlPath, (html) => {
            if (this.panel) {
                // little hack to make the html unique so that the webview is reloaded
                html = html.replace(/\<\/body\>/, `<div id="${utils_1.randomString(8)}"></div></body>`);
                this.panel.webview.html = html;
            }
        });
    }
    send(message) {
        if (this.panel)
            this.panel.webview.postMessage(message);
    }
    handleMessage(message) {
        throw new Error("Method not implemented");
    }
    dispose() {
        if (this.disposable) {
            this.disposable.dispose();
        }
        this.panel = undefined;
    }
    init() {
        let subscriptions = [];
        let options = {
            enableScripts: true,
            retainContextWhenHidden: true,
            localResourceRoots: [vscode_1.Uri.file(this.resourcesPath).with({ scheme: this.resourceScheme })]
        };
        this.panel = vscode_1.window.createWebviewPanel(this.type, this.title, vscode_1.ViewColumn.Two, options);
        subscriptions.push(this.panel);
        subscriptions.push(this.panel.onDidDispose(() => this.dispose()));
        subscriptions.push(this.panel.webview.onDidReceiveMessage((message) => {
            //console.log("Received message from webview: "+JSON.stringify(message));
            this.handleMessage(message);
        }));
        this.disposable = vscode_1.Disposable.from(...subscriptions);
    }
    readWithCache(path, callback) {
        let html = '';
        if (path in this.htmlCache) {
            html = this.htmlCache[path];
            callback(html);
        }
        else {
            fs_1.readFile(path, 'utf8', (err, content) => {
                html = content || "";
                html = this.replaceUris(html, path);
                this.htmlCache[path] = html;
                callback(html);
            });
        }
    }
    replaceUris(html, htmlPath) {
        let basePath = vscode_1.Uri.file(path_1.dirname(htmlPath)).with({ scheme: this.resourceScheme }).toString();
        let regex = /(href|src)\=\"(.+?)\"/g;
        html = html.replace(regex, `$1="${basePath + '$2'}"`);
        return html;
    }
}
exports.CustomView = CustomView;
//# sourceMappingURL=customview.js.map