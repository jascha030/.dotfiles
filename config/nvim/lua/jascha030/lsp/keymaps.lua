---@class jascha030.lsp.Keymaps
---@field client table
---@field buffer table 
local M = {}

---@return jascha030.lsp.Keymaps
function M.new(client, buffer)
    return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
    return self.client.server_capabilities[cap .. 'Provider']
end

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

function M.rename()
    if pcall(require, 'inc_rename') then
        return ':IncRename ' .. vim.fn.expand('<cword>')
    else
        vim.lsp.buf.rename()
    end
end

function M.diagnostic_goto(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil

    return function()
        go({ severity = severity })
    end
end

return M
