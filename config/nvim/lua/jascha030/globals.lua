_G.lreq = require('lreq')

local lsp = lreq('jascha030.lsp')
local icons = lreq('jascha030.core.icons')

_G.Jascha030 = {
    lsp = {
        ---@param config vim.lsp.ClientConfig
        ---@return vim.lsp.ClientConfig
        config_extend = function(config)
            return lsp.config.extend(config)
        end,
    },
    icons = {
        ---@return table<string, string>
        get_icons = function()
            return icons.get_icons()
        end,
    },
}
