"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const appInsights = require("applicationinsights");
const utility_1 = require("./utility");
class AppInsightsClient {
    static sendEvent(eventName, properties) {
        if (this._enableTelemetry) {
            this._client.trackEvent({ name: eventName, properties });
        }
    }
}
AppInsightsClient._client = new appInsights.TelemetryClient("4346cd63-9ece-44be-9116-44c0e559c4e6");
AppInsightsClient._enableTelemetry = utility_1.Utility.getConfiguration().get("enableTelemetry");
exports.AppInsightsClient = AppInsightsClient;
//# sourceMappingURL=appInsightsClient.js.map