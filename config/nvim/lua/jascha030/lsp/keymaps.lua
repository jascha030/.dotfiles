---@diagnostic disable: duplicate-set-field
---
---@class jascha030.lsp.Keymaps
---@field client table
---@field buffer integer
local M = {}

---@param client vim.lsp.Client
---@param buffer integer
---@return jascha030.lsp.Keymaps
function M.new(client, buffer)
    return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

---@param cap string
---@return boolean
function M:has(cap)
    return self.client.server_capabilities[cap .. 'Provider']
end

---@param lhs string
---@param rhs string|fun()
---@param opts table?
function M:map(lhs, rhs, opts)
    opts = opts or {}

    if opts.has and not self:has(opts.has) then
        return
    end

    vim.keymap.set(opts.mode or 'n', lhs, type(rhs) == 'string' and ('<cmd>%s<cr>'):format(rhs) or rhs, {
        silent = true,
        buffer = self.buffer,
        expr = opts.expr,
        desc = opts.desc,
    })
end

---@returns string|nil
function M.rename()
    if pcall(require, 'inc_rename') then
        return ':IncRename ' .. vim.fn.expand('<cword>')
    else
        vim.lsp.buf.rename()
    end
end

---@param next boolean
---@param severity string?
function M.diagnostic_goto(next, severity)
    return function()
        vim.diagnostic.jump({
            float = true,
            severity = vim.diagnostic.severity[severity] or nil,
            count = next and 1 or -1,
        })
    end
end

---@param client vim.lsp.Client
---@param bufnr integer
function M.on_attach(client, bufnr)
    local self = M.new(client, bufnr)
    local diagnostic_goto = M.diagnostic_goto
    local float_opts = { border = BORDER }

    self:map('K', function()
        vim.lsp.buf.hover(float_opts)
    end, { desc = 'Hover' })

    self:map('gK', function()
        vim.lsp.buf.signature_help(float_opts)
    end, { desc = 'Signature Help', has = 'signatureHelp' })

    self:map('<leader><leader>I', 'LspInfo', { desc = 'Lsp Info' })
    self:map('<C-k>', vim.lsp.buf.signature_help, { mode = 'i', desc = 'Signature Help', has = 'signatureHelp' })
    self:map(']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
    self:map('[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
    self:map(']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
    self:map('[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
    self:map(']w', diagnostic_goto(true, 'WARNING'), { desc = 'Next Warning' })
    self:map('[w', diagnostic_goto(false, 'WARNING'), { desc = 'Prev Warning' })
    self:map('<leader>r', M.rename, { expr = true, desc = 'Rename', has = 'rename' })

    -- self:map('<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
    -- self:map('<leader>xd', 'Telescope diagnostics', { desc = 'Telescope Diagnostics' })
end

return M
