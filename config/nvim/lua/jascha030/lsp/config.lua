---@class jascha030.lsp.Config
local M = {}

---@param server string LSP server name
---@param message string
---@param level? integer
local function config_error(server, message, level)
    error('Failed to load config for ' .. server .. ' ' .. message, level)
end

local function make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    capabilities.textDocument.formatting = {
        dynamicRegistration = false,
    }

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
        documentationFormat = { 'markdown', 'plaintext' },
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

---@param server string LSP server name
---@return vim.lsp.ClientConfig
function M.get(server)
    local ok, config = pcall(require, 'jascha030.lsp.servers.' .. server)
    if not ok then
        config = {}
    end

    if type(config) == 'function' then
        ok, config = pcall(config)
        if not ok then
            config_error(server, 'Error: ' .. config, 2)
        end

        if type(config) ~= 'table' then
            config_error(server, 'provided callback should be a table, got ' .. type(config) .. ' instead', 2)
        end

        return M.extend(config)
    end

    if type(config) ~= 'table' then
        config_error(server, 'a table was expected, got ' .. type(config) .. ' instead', 2)
    end

    return M.extend(config)
end

return M
