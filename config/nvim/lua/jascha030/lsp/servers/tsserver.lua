return function()
    local util = require('lspconfig.util')

    local inlayHints = {
        enumMemberValues = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterTypes = { enabled = true },
        parameterNames = { enabled = 'all' },
    }

    return {
        root_dir = function(filename, _)
            return util.find_git_ancestor(filename)
                or util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')(filename)
        end,
        settings = {
            javascript = {
                format = { enable = false },
                inlayHints,
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
                inlayHints,
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
end
