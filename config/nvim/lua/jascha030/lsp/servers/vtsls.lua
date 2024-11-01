---@type _.lspconfig.settings.vtsls.InlayHints
local inlayHints = {
    parameterNames = { enabled = 'all' },
    parameterTypes = { enabled = true },
    variableTypes = { enabled = true },
    propertyDeclarationTypes = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
}

---@type lspconfig.options.vtsls
local vtsls = {
    single_file_support = false,
    settings = {
        vtsls = {
            experimental = {
                enableProjectDiagnostics = true,
            },
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
        },
        javascript = {
            format = { enable = false },
            inlayHints,
        },
        typescript = {
            format = { enable = false },
            implementationsCodeLens = {
                enabled = true,
                showOnInterfaceMethods = true,
            },
            inlayHints,
            preferences = {
                useAliasesForRenames = false,
                preferTypeOnlyAutoImports = true,
            },
            tsserver = {
                maxTsServerMemory = 8192,
            },
            referencesCodeLens = {
                showOnAllFunctions = true,
                enabled = true,
            },
        },
    },
}

return vtsls
