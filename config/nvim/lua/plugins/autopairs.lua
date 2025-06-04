---@type LazyPluginSpec
local M = {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = { disable_in_macro = false },
}

return M
