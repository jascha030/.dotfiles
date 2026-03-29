local M = {}

local function success(callback, result)
    if callback == nil then
        return
    end

    vim.schedule(function()
        callback(nil, result)
    end)
end

local function failure(callback, code, message)
    if callback == nil then
        return
    end

    vim.schedule(function()
        callback({
            code = code,
            message = message,
        }, nil)
    end)
end

function M.start(_, _)
    local zsh_symbols = require('jascha030.zsh_symbols')
    local next_id = 0
    local shutdown_requested = false
    local terminated = false

    local handlers = {
        initialize = function()
            return {
                capabilities = {
                    definitionProvider = true,
                    documentSymbolProvider = true,
                    workspaceSymbolProvider = true,
                    textDocumentSync = vim.lsp.protocol.TextDocumentSyncKind.None,
                },
                serverInfo = {
                    name = 'zsh_local',
                },
            }
        end,
        shutdown = function()
            shutdown_requested = true
            return vim.NIL
        end,
        ['textDocument/definition'] = function(params)
            return zsh_symbols.definition(params)
        end,
        ['textDocument/documentSymbol'] = function(params)
            return zsh_symbols.document_symbols(params.textDocument.uri)
        end,
        ['workspace/symbol'] = function(params)
            return zsh_symbols.workspace_symbols(params.query or '')
        end,
    }

    return {
        request = function(method, params, callback, notify_reply_callback)
            if terminated then
                return false
            end

            next_id = next_id + 1

            if shutdown_requested and method ~= 'shutdown' then
                failure(
                    callback,
                    vim.lsp.protocol.ErrorCodes.InvalidRequest,
                    string.format('Request not allowed after shutdown: %s', method)
                )

                return true, next_id
            end

            if notify_reply_callback ~= nil then
                vim.schedule(function()
                    notify_reply_callback(next_id)
                end)
            end

            local handler = handlers[method]

            if handler == nil then
                failure(
                    callback,
                    vim.lsp.protocol.ErrorCodes.MethodNotFound,
                    string.format('Method not supported: %s', method)
                )
                return true, next_id
            end

            local ok, result = pcall(handler, params or {})

            if not ok then
                failure(
                    callback,
                    vim.lsp.protocol.ErrorCodes.InternalError,
                    string.format('zsh_local request failed: %s', result)
                )

                return true, next_id
            end

            success(callback, result)

            return true, next_id
        end,
        notify = function(method, _)
            if method == 'exit' then
                terminated = true
            end

            return true
        end,
        is_closing = function()
            return terminated
        end,
        terminate = function()
            terminated = true
        end,
    }
end

return M
