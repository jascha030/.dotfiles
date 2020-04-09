"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const clipboardy = require("clipboardy");
var Clipboard;
(function (Clipboard) {
    function copy(text) {
        return clipboardy.write(text);
    }
    Clipboard.copy = copy;
    function read() {
        return clipboardy.read();
    }
    Clipboard.read = read;
})(Clipboard || (Clipboard = {}));
exports.default = Clipboard;
//# sourceMappingURL=clipboard.js.map