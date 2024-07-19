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
            php_bin = '/opt/homebrew/bin/php',
            bin = vim.fn.stdpath('data') .. '/mason/bin/phpactor'
        },
    },
}

function M.build()
    require('phpactor.handler.update')()
end

return M
