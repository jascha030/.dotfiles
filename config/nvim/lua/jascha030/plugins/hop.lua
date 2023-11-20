local M = {
    'phaazon/hop.nvim',
    cond = false,
    branch = 'v2',
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
