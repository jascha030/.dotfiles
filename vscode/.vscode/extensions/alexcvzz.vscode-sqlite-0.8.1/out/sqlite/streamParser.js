"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const stream_1 = require("stream");
class StreamParser extends stream_1.Writable {
    constructor(parser) {
        super();
        this.parser = parser;
        this.once('finish', () => {
            this.emit('done', parser.done());
        });
    }
    _write(chunk, encoding, callback) {
        let data = chunk.toString();
        this.parser.push(data);
        callback();
    }
}
exports.StreamParser = StreamParser;
//# sourceMappingURL=streamParser.js.map