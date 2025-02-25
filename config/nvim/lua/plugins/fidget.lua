---@type LazyPluginSpec
local M = {
    'j-hui/fidget.nvim',
    name = 'fidget',
    tag = 'legacy',
    opts = {
        text = { spinner = 'dots' },
        window = { relative = 'editor', blend = 0, zindex = nil },
        sources = { phpactor = { ignore = true } },
    },
}

return M
