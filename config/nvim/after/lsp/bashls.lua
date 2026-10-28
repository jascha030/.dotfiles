---@type vim.lsp.Config
return {
    filetypes = { 'bash', 'sh' },
    ---@type lspconfig.settings.bashls
    settings = {
        bashIde = {
            shfmt = { enable = false }, -- let conform handle formatting
            shellcheck = { enable = true },
        },
    },
}
