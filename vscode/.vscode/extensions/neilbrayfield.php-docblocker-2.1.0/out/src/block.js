"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const TypeUtil_1 = require("./util/TypeUtil");
/**
 * Represents a potential code block.
 *
 * This abstract class serves as a base class that includes lots of
 * helpers for dealing with blocks of code and has the basic interface
 * for working with the documenter object
 */
class Block {
    /**
     * Creates an instance of Block.
     *
     * @param {Position} position
     * @param {TextEditor} editor
     */
    constructor(position, editor) {
        /**
         * Default signature end pattern
         *
         * @type {RegExp}
         */
        this.signatureEnd = /[\{;]/;
        this.position = position;
        this.editor = editor;
        this.setSignature(this.getBlock(position, this.signatureEnd));
    }
    /**
     * This should be a simple test to determine wether this matches
     * our intended block signiture and we can proceed to properly
     * match
     *
     * @returns {boolean}
     */
    test() {
        return this.pattern.test(this.signature);
    }
    /**
     * Run a match to break the signiture into the constituent parts
     *
     * @returns {object}
     */
    match() {
        return this.signature.match(this.pattern);
    }
    /**
     * Set up the signiture string.
     *
     * This is usually detected from the position
     *
     * @param {string} signiture
     */
    setSignature(signiture) {
        this.signature = signiture;
    }
    /**
     * This matches a block and tries to find everything up to the
     * end character which is a regex to determine if it's the right
     * character
     *
     * @param {Position} initial
     * @param {RegExp} endChar
     * @returns {string}
     */
    getBlock(initial, endChar) {
        let line = initial.line + 1;
        let part = this.editor.document.lineAt(line).text;
        let initialCharacter = part.search(/[^\s]/);
        if (initialCharacter === -1) {
            return "";
        }
        let start = new vscode_1.Position(initial.line + 1, initialCharacter);
        while (!endChar.test(part)) {
            line++;
            part = this.editor.document.lineAt(line).text;
        }
        let end = new vscode_1.Position(line, part.search(endChar));
        let block = new vscode_1.Range(start, end);
        return this.editor.document.getText(block);
    }
    /**
     * Parse a nested block of code
     *
     * @param {string} context
     * @param {string} [opening]
     * @param {string} [closing]
     * @returns {string}
     */
    getEnclosed(context, opening, closing) {
        let opened = 0;
        let contextArray = context.split("");
        let endPos = 0;
        for (let index = 0; index < contextArray.length; index++) {
            let char = contextArray[index];
            if (char == closing && opened == 0) {
                endPos = index;
                break;
            }
            else if (char == closing) {
                opened--;
            }
            else if (char == opening) {
                opened++;
            }
            endPos = index;
        }
        return context.substr(0, endPos);
    }
    /**
     * Get the header for the class
     *
     * @returns {string}
     */
    getClassHead() {
        if (this.classHead === undefined) {
            let text = this.editor.document.getText(new vscode_1.Range(new vscode_1.Position(0, 0), new vscode_1.Position(150, 0)));
            let regex = /\s*(abstract|final)?\s*(class|trait|interface)/gm;
            let match = regex.exec(text);
            let end = this.editor.document.positionAt(match.index);
            let range = new vscode_1.Range(new vscode_1.Position(0, 0), end);
            this.classHead = this.editor.document.getText(range);
        }
        return this.classHead;
    }
    /**
     * Take the value and parse and try to infer its type
     *
     * @param {string} value
     * @returns {string}
     */
    getTypeFromValue(value) {
        let result;
        // Check for bool
        if (value.match(/^\s*(false|true)\s*$/i) !== null) {
            return TypeUtil_1.default.instance.getFormattedTypeByName('bool');
        }
        // Check for int
        if (value.match(/^\s*([\d-]+)\s*$/) !== null) {
            return TypeUtil_1.default.instance.getFormattedTypeByName('int');
        }
        // Check for float
        if (value.match(/^\s*([\d.-]+)\s*$/) !== null) {
            return 'float';
        }
        // Check for string
        if (value.match(/^\s*(["'])/) !== null) {
            return 'string';
        }
        // Check for array
        if (value.match(/^\s*(array\(|\[)/) !== null) {
            return 'array';
        }
        return '[type]';
    }
}
exports.Block = Block;
//# sourceMappingURL=block.js.map