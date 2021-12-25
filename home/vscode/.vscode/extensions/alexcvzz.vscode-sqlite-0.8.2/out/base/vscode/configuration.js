"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
function getConfigurationValue(prefix, section, defaultValue, scope) {
    let workspaceConfiguration;
    if (scope) {
        workspaceConfiguration = vscode_1.workspace.getConfiguration(prefix, scope);
    }
    else {
        workspaceConfiguration = vscode_1.workspace.getConfiguration();
        section = prefix + "." + section;
    }
    return workspaceConfiguration.get(section, defaultValue);
}
exports.getConfigurationValue = getConfigurationValue;
//# sourceMappingURL=configuration.js.map