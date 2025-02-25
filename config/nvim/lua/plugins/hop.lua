---@type LazyPluginSpec
local M = {
    'smoka7/hop.nvim',
    version = "*",
    name = 'hop',
    cmd = {
        'HopWord',
        'HopLine',
        'HopChar1',
        'HopChar2',
        'HopPattern',
    },
    opts = {
        keys = 'etovxqpdygfblzhckisuran',
        jump_on_sole_occurrence = false,
    },
}

return M
