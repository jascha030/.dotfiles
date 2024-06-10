---@type LazySpec
local M = {
    'gbprod/phpactor.nvim',
    ft = { 'php' },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
    },
    opts = {
        install = {
            php_bin = vim.fn.stdpath('data') .. '/opt/homebrew/bin/php',
            bin = vim.fn.expand('~/tools/phpactor'),
        },
    },
}

function M.build()
    require('phpactor.handler.update')()
end

return M
