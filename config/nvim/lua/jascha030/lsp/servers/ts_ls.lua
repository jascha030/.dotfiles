---@diagnostic disable: missing-fields
return function()
    local util = require('lspconfig.util')

    local inlayHints = {
        enumMemberValues = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterTypes = { enabled = true },
        parameterNames = { enabled = 'all' },
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
    }

    ---@type lspconfig.options.ts_ls
    local ts_ls = {
        root_dir = function(filename, _)
            return util.find_git_ancestor(filename)
                or util.root_pattern('.git', 'package.json', 'tsconfig.json', 'jsconfig.json')(filename)
        end,
        settings = {
            javascript = {
                format = { enable = false },
                inlayHints = inlayHints,
            },
            typescript = {
                format = { enable = false },
                implementationsCodeLens = { enabled = true },
                preferGoToSourceDefinition = false,
                referencesCodeLens = {
                    showOnAllFunctions = true,
                    enabled = true,
                },
                suggest = { completeFunctionCalls = true },
                inlayHints = inlayHints,
                preferences = {
                    useAliasesForRenames = false,
                    importModuleSpecifier = 'non-relative',
                },
                experimental = {
                    aiCodeActions = {
                        extractInterface = true,
                        missingFunctionDeclaration = true,
                        extractType = true,
                        inferAndAddTypes = true,
                        extractFunction = true,
                        extractConstant = true,
                        classIncorrectlyImplementsInterface = true,
                        classDoesntImplementInheritedAbstractMember = true,
                        addNameToNamelessParameter = true,
                    },
                    enableProjectDiagnostics = true,
                    tsserver = { maxTsServerMemory = 4096 },
                },
            },
        },
    }

    return ts_ls
end
