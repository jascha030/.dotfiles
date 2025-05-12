---@diagnostic disable: missing-fields
---@type lspconfig.options.stylelint_lsp
local stylelint_lsp = {
    filetypes = {
        'css',
        'less',
        'scss',
        'sugarss',
        'vue',
        'wxss',
    },
    ---@type lspconfig.settings.stylelint_lsp
    settings = {
        stylelintplus = {},
    },
}

return require('jascha030.lsp').config.extend(stylelint_lsp)
