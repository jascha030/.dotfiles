local M = {
    'folke/paint.nvim',
    opts = {
        highlights = {
            {
                filter = { filetype = 'lua' },
                pattern = '%s*%-%-%-%s*(@%w+)',
                hl = '@keyword',
            },
            {
                filter = { filetype = 'zsh' },
                pattern = 'function',
                hl = '@keyword.function',
            },
        },
    },
}

return M
