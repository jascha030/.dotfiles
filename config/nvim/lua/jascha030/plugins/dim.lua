---@type LazyPluginSpec
local M = {
    '0oAstro/dim.lua',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'neovim/nvim-lspconfig',
    },
    config = true,
}

return M
