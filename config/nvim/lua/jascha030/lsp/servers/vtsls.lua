---@diagnostic disable: missing-fields
local util = require('lspconfig.util')

---@type _.lspconfig.settings.vtsls.InlayHints
local inlayHints = {
    parameterNames = {
        enabled = 'all',
    },
    parameterTypes = {
        enabled = true,
    },
    variableTypes = {
        enabled = true,
    },
    propertyDeclarationTypes = {
        enabled = true,
    },
    functionLikeReturnTypes = {
        enabled = true,
    },
    enumMemberValues = {
        enabled = true,
    },
}

---@type vim.lsp.ClientConfig
local vtsls = {
    ---@diagnostic disable-next-line: assign-type-mismatch
    root_dir = function(filename, _)
        return vim.fs.dirname(vim.fs.find('.git', { path = filename, upward = true })[1])
            or util.root_pattern('.git', 'package.json', 'tsconfig.json', 'jsconfig.json')(filename)
    end,
    single_file_support = false,
    settings = {
        vtsls = {
            experimental = { enableProjectDiagnostics = true },
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
        },
        javascript = { inlayHints },
        typescript = {
            -- format = {
            --     enable = false,
            -- },
            -- implementationsCodeLens = {
            --     enabled = true,
            --     showOnInterfaceMethods = true,
            -- },
            inlayHints,
            -- preferences = {
            --     useAliasesForRenames = false,
            -- },
            -- preferences = {
            --     useAliasesForRenames = false,
            --     preferTypeOnlyAutoImports = true,
            -- },
            -- tsserver = {
            -- maxTsServerMemory = 8192,
            -- },
            -- referencesCodeLens = {
            --     showOnAllFunctions = true,
            --     enabled = true,
            -- },
        },
    },
}

return vtsls
