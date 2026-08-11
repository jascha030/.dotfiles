---@diagnostic disable: duplicate-set-field
---@class jascha030.lsp.Module
---@field public keymaps jascha030.lsp.Keymaps
---@field public config jascha030.lsp.Config
local M = {
    keymaps = require('jascha030.lsp.keymaps'),
    config = require('jascha030.lsp.config'),
}

---@param on_attach fun(client, buffer)
---@param group string|nil
function M.lsp_attach(on_attach, group)
    group = group or nil

    local attach = {
        callback = function(args)
            -- stylua: ignore
            if not (args.data and args.data.client_id) then return end
            on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
        end,
    }

    if nil ~= group then
        attach.group = group
        vim.api.nvim_create_augroup(group, {})
    end

    vim.api.nvim_create_autocmd('LspAttach', attach)
end

---@diagnostic disable-next-line: duplicate-set-field
function M.inlay_hints()
    if not vim.fn.has('nvim-0.10') == 1 then
        return
    end

    M.lsp_attach(function(client, bufnr)
        if client.server_capabilities.inlayHintProvider ~= nil then
            local ok, err = pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
            if not ok then
                vim.notify_once('Inlay hints error: ' .. tostring(err), vim.log.levels.WARN)
            end
        end
    end)

    -- Init lsp-inlayhints plugin if available
    local ok, inlayhints = pcall(require, 'lsp-inlayhints')
    if ok then
        M.lsp_attach(inlayhints.on_attach, 'LspAttach_inlayhints')
    end
end

return M
