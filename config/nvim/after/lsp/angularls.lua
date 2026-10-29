---@type vim.lsp.Config
return {
    root_markers = {
        'angular.json',
        'nx.json',
    },
    filetypes = {
        'typescript',
        'html',
        'typescriptreact',
        'htmlangular',
    },
    workspace_required = true,
    ---@type lspconfig.settings.angularls
    -- settings = {},
}
