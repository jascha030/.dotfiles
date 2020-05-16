"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const regex_1 = require("./regex");
exports.NullToken = {
    id: "__null__",
    text: "", value: "",
    start: -1, end: -1,
    isA: (id) => { return id === "__null__"; }
};
function tokenize(str, tokenizationRules) {
    let tokens = [];
    for (let rule of tokenizationRules) {
        let matches = regex_1.findMatches(rule.regex, str);
        let ruleTokens = matches.map(match => {
            let token = {
                id: rule.id,
                text: match.match,
                value: rule.replace ? rule.replace(rule.id, rule.regex, match.match, match.groups) : match.match,
                start: match.index,
                end: match.index + match.length,
                isA: (id) => { return id === rule.id; }
            };
            return token;
        });
        tokens.push(...ruleTokens);
    }
    tokens = tokens.sort((tknA, tknB) => tknA.start < tknB.start ? -1 : 1);
    return tokens;
}
exports.tokenize = tokenize;
//# sourceMappingURL=tokenizer.js.map