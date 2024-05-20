---@type LazyPluginSpec
local M = {
    'folke/flash.nvim',
    lazy = true,
    cond = false,
    event = 'VeryLazy',
}

function M.keys(_, _)
    local flash = lreq('flash')

    return {
        { 's', mode = { 'n', 'x', 'o' }, flash.jump, desc = 'Flash' },
        { 'S', mode = { 'n', 'x', 'o' }, flash.treesitter, desc = 'Flash Treesitter' },
        { '<c-s>', mode = { 'c' }, flash.toggle, desc = 'Toggle Flash Search' },
    }
end

return M
