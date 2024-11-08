---@diagnostic disable: missing-fields
return {
    filetypes = {
        'css',
        'less',
        'scss',
        'sugarss',
        'vue',
        'wxss',
        -- 'javascript',
        -- 'javascriptreact',
        -- 'typescript',
        -- 'typescriptreact',
    },
    settings = {
        ---@type _.lspconfig.settings.stylelint_lsp.Stylelintplus
        stylelintplus = {},
    },
}
