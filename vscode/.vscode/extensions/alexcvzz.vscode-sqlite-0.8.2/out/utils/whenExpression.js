"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Comparator;
(function (Comparator) {
    Comparator["EQUAL"] = "EQUAL";
    Comparator["NOT_EQUAL"] = "NOT_EQUAL";
})(Comparator || (Comparator = {}));
var Operator;
(function (Operator) {
    Operator["AND"] = "AND";
    Operator["OR"] = "OR";
})(Operator || (Operator = {}));
function createWhenExpression(str) {
    let match = str.match(/^\s*\w+\s*(\s+(=|!)=\s+\w+\s*)?((\s+(&&|\|\|)\s+\w+\s*(\s+(=|!)=\s+\w+\s*)?))*$/);
    if (!match)
        throw new Error(`Invalid when string: '${str}'`);
    let tokens = str.split(/\s+/);
    tokens = tokens.filter(token => token !== "").map(token => token.trim()).map(token => token.toLowerCase());
    console.log(tokens);
    let expression = [];
    let clause = { variable: "" };
    for (let token of tokens) {
        if (token == "&&") {
            expression.push(clause);
            expression.push(Operator.AND);
            clause = { variable: "" };
        }
        else if (token == "||") {
            expression.push(clause);
            expression.push(Operator.OR);
            clause = { variable: "" };
        }
        else if (token == "==") {
            clause.comparator = Comparator.EQUAL;
        }
        else if (token == "!=") {
            clause.comparator = Comparator.NOT_EQUAL;
        }
        else {
            if (clause.comparator) {
                clause.value = token;
            }
            else {
                clause.variable = token;
            }
        }
    }
    expression.push(clause);
    console.log(expression);
    return {
        verify: (values) => {
            let verified = false;
            for (let token of expression) {
                if (token instanceof Number) {
                    let operator = token;
                }
                else {
                    let clause = token;
                }
            }
            return verified;
        }
    };
}
exports.createWhenExpression = createWhenExpression;
//# sourceMappingURL=whenExpression.js.map