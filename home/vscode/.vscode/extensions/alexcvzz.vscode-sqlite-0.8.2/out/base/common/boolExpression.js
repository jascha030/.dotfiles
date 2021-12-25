"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const tokenizer_1 = require("./tokenizer");
var Comparator;
(function (Comparator) {
    Comparator["EQUAL"] = "==";
    Comparator["NOT_EQUAL"] = "!=";
})(Comparator = exports.Comparator || (exports.Comparator = {}));
var Operator;
(function (Operator) {
    Operator["AND"] = "&&";
    Operator["OR"] = "||";
})(Operator = exports.Operator || (exports.Operator = {}));
var ExprToken;
(function (ExprToken) {
    ExprToken["OPERATOR"] = "operator";
    ExprToken["LITERAL"] = "literal";
    ExprToken["COMPARATOR"] = "comparator";
})(ExprToken || (ExprToken = {}));
var BoolExpression;
(function (BoolExpression) {
    function compile(str) {
        let rules = [
            { id: ExprToken.OPERATOR, regex: /(\&\&|\|\|)/ },
            { id: ExprToken.COMPARATOR, regex: /(==|!=)/ },
            { id: ExprToken.LITERAL, regex: /\w+/ },
        ];
        let tokens = tokenizer_1.tokenize(str, rules);
        let exprParts = _convertTokensToExpressionParts(tokens);
        let expr = _buildExpressionFromExpressionParts(exprParts);
        return expr;
    }
    BoolExpression.compile = compile;
    function _convertTokensToExpressionParts(tokens) {
        let parts = [];
        for (let i = 0; i < tokens.length; i++) {
            let token = tokens[i];
            let nextToken = tokens[i + 1] || tokenizer_1.NullToken;
            let nextNextToken = tokens[i + 2] || tokenizer_1.NullToken;
            if (token.isA(ExprToken.LITERAL) && nextToken.isA(ExprToken.COMPARATOR)) {
                // the token after next token has to be lit
                if (!nextNextToken.isA(ExprToken.LITERAL))
                    throw Error(`Error near '${token.text}'`);
                let clause = new ComparationImpl(token.value, nextToken.value, nextNextToken.value);
                parts.push(clause);
                i += 2; // skip 2
                continue;
            }
            if (token.isA(ExprToken.LITERAL) && !nextToken.isA(ExprToken.COMPARATOR)) {
                // next token has to be an operator or nothing
                if (!nextToken.isA(ExprToken.OPERATOR) && !nextToken.isA(tokenizer_1.NullToken.id))
                    throw Error(`Error near '${token.text}'`);
                let clause = new EvaluationImpl(token.value);
                parts.push(clause);
                continue;
            }
            if (token.isA(ExprToken.OPERATOR)) {
                // next token has to be lit
                if (!nextToken.isA(ExprToken.LITERAL))
                    throw Error(`Error near '${token.text}'`);
                parts.push(token.value);
                continue;
            }
            throw Error(`Error near '${token.text}'`);
        }
        return parts;
    }
    function _buildExpressionFromExpressionParts(parts) {
        let part = parts[0];
        let next = parts[1];
        if (typeof part === "string") {
            throw Error(`Expected a clause but got an operator: '${part}'`);
        }
        else {
            if (typeof next === "string") {
                let right = _buildExpressionFromExpressionParts(parts.slice(2));
                return new OperationImpl(next, part, right);
            }
            if (next === undefined) {
                return part;
            }
            throw Error(`Expected an operator or nothing but got a clause: '${JSON.stringify(part)}'`);
        }
    }
})(BoolExpression = exports.BoolExpression || (exports.BoolExpression = {}));
class EvaluationImpl {
    constructor(variable) {
        this.variable = variable;
    }
    eval(context) {
        if (this.variable.toLowerCase() === "true")
            return true;
        if (this.variable.toLowerCase() === "false")
            return false;
        let varValue = context[this.variable];
        return Boolean(varValue);
    }
}
class ComparationImpl {
    constructor(variable, comparator, value) {
        this.variable = variable;
        this.comparator = comparator;
        this.value = value;
    }
    eval(context) {
        let varValue = context[this.variable];
        switch (this.comparator) {
            case Comparator.EQUAL:
                return varValue === this.value;
            case Comparator.NOT_EQUAL:
                return varValue !== this.value;
            default:
                throw Error(`Comparator '${this.comparator}' not supported.`);
        }
    }
}
class OperationImpl {
    constructor(operator, left, right) {
        this.operator = operator;
        this.left = left;
        this.right = right;
    }
    eval(context) {
        let leftResult = this.left.eval(context);
        let rightResult = this.right.eval(context);
        switch (this.operator) {
            case Operator.AND:
                return leftResult && rightResult;
            case Operator.OR:
                return leftResult || rightResult;
            default:
                throw Error(`Operator '${this.operator}' not supported.`);
        }
    }
}
//# sourceMappingURL=boolExpression.js.map