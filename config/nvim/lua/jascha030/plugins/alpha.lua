---@type LazyPluginSpec
local M = {
    'goolord/alpha-nvim',
    event = { 'VimEnter' },
}

function M.opts()
    return require('alpha.themes.startify').config
end

function M.config(_, opts)
    require('alpha').setup(opts)
end

return M
