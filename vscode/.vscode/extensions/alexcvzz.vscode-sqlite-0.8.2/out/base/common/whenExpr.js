"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const strings_1 = require("./strings");
var Comparator;
(function (Comparator) {
    Comparator["EQUAL"] = "EQUAL";
    Comparator["NOT_EQUAL"] = "NOT_EQUAL";
})(Comparator = exports.Comparator || (exports.Comparator = {}));
var Operator;
(function (Operator) {
    Operator["AND"] = "AND";
    Operator["OR"] = "OR";
})(Operator = exports.Operator || (exports.Operator = {}));
const WHEN_EXPR_REGEX = /^\s*\w+\s*(\s+(=|!)=\s+\w+\s*)?((\s+(&&|\|\|)\s+\w+\s*(\s+(=|!)=\s+\w+\s*)?))*$/;
var WhenExpr;
(function (WhenExpr) {
    function parse(str) {
        // validate
        let match = str.match(WHEN_EXPR_REGEX);
        if (!match)
            throw new Error(`Invalid when-expression: '${str}'`);
        let tokens = str.split(/\s+/);
        tokens = strings_1.normalize(tokens);
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
        return {
            expression: expression,
            verify: (values) => verifyExpression(expression, values)
        };
    }
    WhenExpr.parse = parse;
})(WhenExpr = exports.WhenExpr || (exports.WhenExpr = {}));
function verifyExpression(expression, values) {
    let verified = false;
    let lastOperator = undefined;
    for (let token of expression) {
        if (token instanceof Object) {
            let clause = token;
            let clauseVerified = false;
            let value = values[clause.variable] instanceof String ? values[clause.variable].toLowerCase() : values[clause.variable];
            if (clause.value !== undefined && clause.comparator == Comparator.EQUAL) {
                clauseVerified = (clause.value === value);
            }
            else if (clause.value !== undefined && clause.comparator === Comparator.NOT_EQUAL) {
                clauseVerified = (clause.value !== value);
            }
            else {
                clauseVerified = Boolean(value);
            }
            if (lastOperator === Operator.AND) {
                verified = verified && clauseVerified;
            }
            else if (lastOperator === Operator.OR) {
                verified = verified || clauseVerified;
            }
            else {
                // first clause
                verified = clauseVerified;
            }
        }
        else {
            lastOperator = token;
        }
    }
    return verified;
}
//# sourceMappingURL=whenExpr.js.map