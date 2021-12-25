"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const fs = require("fs");
/**
 * Provides helper function to types
 */
class Config {
    constructor() {
        /**
         * Are we in test mode or live
         *
         * @type {boolean}
         */
        this.isLive = true;
    }
    /**
     * Returns the instance for this util
     *
     * @returns {Config}
     */
    static get instance() {
        if (this._instance == null) {
            this._instance = new this();
            this._instance.load();
        }
        return this._instance;
    }
    /**
     * Set whether this is live mode or not
     *
     * @param {boolean} bool
     */
    set live(bool) {
        this.isLive = bool;
    }
    /**
     * Load in the defaults or the config
     */
    load() {
        if (!this.isLive) {
            let config = {};
            let packageJson = JSON.parse(fs.readFileSync(__dirname + '/../../../package.json').toString());
            let props = packageJson.contributes.configuration.properties;
            for (var key in props) {
                var item = props[key];
                config[key.replace('php-docblocker.', '')] = item.default;
            }
            this.data = config;
        }
    }
    /**
     * Add overrides
     *
     * @param overrides
     */
    override(overrides) {
        this.data = Object.assign(Object.assign({}, this.data), overrides);
    }
    /**
     * Get a settings from the config or the mocked config
     *
     * @param {string} setting
     */
    get(setting) {
        if (this.isLive) {
            return vscode_1.workspace.getConfiguration('php-docblocker').get(setting);
        }
        return this.data[setting];
    }
}
exports.default = Config;
//# sourceMappingURL=config.js.map