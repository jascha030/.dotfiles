---@type vim.lsp.Config
local tsls = {
    single_file_support = false,
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },

    settings = {
        typescript = {
            experimental = {
                useTsgo = true,
            },
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
            tsserver = {
                maxTsServerMemory = 8192,
                experimental = {
                    enableProjectDiagnostics = true,
                },
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

tsls.settings.javascript = vim.tbl_deep_extend('force', {}, tsls.settings.typescript, tsls.settings.javascript or {})

return tsls
