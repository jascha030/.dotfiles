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

-- TODO: Fix this query :P
-- {
-- filter = { filetype = 'php' },
-- pattern = '%s*%*% %s*(@%w+)',
-- hl = '@keyword',
-- },

return M
