"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const pkg = require('../../package.json');
var Constants;
(function (Constants) {
    /* extension */
    Constants.extensionName = pkg.name;
    Constants.extensionDisplayName = pkg.displayName;
    Constants.extensionVersion = pkg.version;
    /* output channel */
    Constants.outputChannelName = `${Constants.extensionDisplayName}`;
    /* explorer */
    Constants.sqliteExplorerViewId = pkg.contributes.views.explorer[0].id;
})(Constants = exports.Constants || (exports.Constants = {}));
//# sourceMappingURL=constants.js.map