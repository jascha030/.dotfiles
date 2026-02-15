---@diagnostic disable: missing-fields
local inlayHints = {
    parameterNames = { enabled = 'all' },
    parameterTypes = { enabled = true },
    variableTypes = { enabled = true },
    propertyDeclarationTypes = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
}

---@type vim.lsp.Config
return Jascha030.lsp.config_extend({
    root_markers = {
        'tsconfig.json',
        'jsconfig.json',
        'package.json',
        'vite.config.js',
        'vite.config.ts',
        '.git',
    },
    single_file_support = false,
    settings = {
        vtsls = {
            experimental = { enableProjectDiagnostics = true },
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
        },
        javascript = { inlayHints },
        typescript = { inlayHints },
    },
})
