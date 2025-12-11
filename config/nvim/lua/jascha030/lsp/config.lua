---@class jascha030.lsp.Config
---@field extend fun(config: vim.lsp.ClientConfig): vim.lsp.ClientConfig
---@field get fun(server: string): vim.lsp.ClientConfig
local M = {}

local function make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    capabilities.textDocument.formatting = { dynamicRegistration = false }
    capabilities.textDocument.semanticTokens.augmentsSyntaxTokens = false
    capabilities.textDocument.completion.completionItem = {
        contextSupport = true,
        snippetSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        resolveSupport = {
            properties = {
                'documentation',
                'detail',
                'additionalTextEdits',
            },
        },
        labelDetailsSupport = true,
        documentationFormat = {
            'markdown',
            'plaintext',
        },
    }

    capabilities.experimental = {
        hoverActions = true,
        hoverRange = true,
        serverStatusNotification = true,
        codeActionGroup = true,
        ssr = true,
        commands = {
            'rust-analyzer.runSingle',
            'rust-analyzer.debugSingle',
            'rust-analyzer.showReferences',
            'rust-analyzer.gotoLocation',
            'editor.action.triggerParameterHints',
        },
    }

    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

    return require('blink.cmp').get_lsp_capabilities(capabilities, true)
end

---@param config vim.lsp.ClientConfig
---@return vim.lsp.ClientConfig
function M.extend(config)
    local merge = { {}, {
        capabilities = make_capabilities(),
        flags = { debounce_text = 150 },
    } }

    if type(config) == 'table' and not vim.tbl_isempty(config) then
        table.insert(merge, config)
    end

    return vim.tbl_deep_extend('force', unpack(merge))
end

return M
