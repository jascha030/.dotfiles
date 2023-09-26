local M = {}

local config = require("jascha030.config")

function M.setup(options)
	config.setup(options)

	require("jascha030.utils.keymaps").set_keymaps(config.options.keymaps)
	require("jascha030.utils.opts").set_opts(config.options.opts)

	require("jascha030.lazy")
end

return M
