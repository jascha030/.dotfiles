---@type LazySpec
local M = {
    'gbprod/phpactor.nvim',
    ft = { 'php' },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
    },
}

function M.config(_, opts)
    require('phpactor').setup(opts)
end

function M.build()
    require('phpactor.handler.update')()
end

return M
