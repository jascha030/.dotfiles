---@type vim.lsp.Config
local tsls = {
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },

    settings = {
        ['js/ts'] = {
            workspaceSymbols = {
                excludeLibrarySymbols = true,
                scope = 'allOpenProjects',
            },
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = {
                completeFunctionCalls = true,
            },
            format = { enable = false },
            preferences = {
                useAliasesForRenames = true,
                preferTypeOnlyAutoImports = true,
            },
            referencesCodeLens = {
                showOnAllFunctions = true,
                enabled = true,
            },
            implementationsCodeLens = {
                enabled = true,
                showOnInterfaceMethods = true,
                showOnAllClassMethods = true,
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

return tsls
