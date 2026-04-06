---@type vim.lsp.Config
local vtsls = {
    single_file_support = false,
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    ---@type lspconfig.settings.vtsls
    settings = {
        vtsls = {
            experimental = { enableProjectDiagnostics = true },
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
        },
        typescript = {
            updateImportsOnFileMove = {
                enabled = 'always',
            },
            implementationsCodeLens = {
                enabled = true,
                showOnAllClassMethods = true,
                showOnInterfaceMethods = true,
            },
            suggest = {
                completeFunctionCalls = true,
            },
            format = {
                enable = false,
            },
            preferences = {
                useAliasesForRenames = true,
                preferTypeOnlyAutoImports = true,
            },
            tsserver = {
                maxTsServerMemory = 8192,
            },
            referencesCodeLens = {
                showOnAllFunctions = true,
                enabled = true,
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
            },
        },
    },
}

vtsls.settings.javascript = vim.tbl_deep_extend('force', {}, vtsls.settings.typescript, vtsls.settings.javascript or {})

return Jascha030.lsp.config_extend(vtsls)
