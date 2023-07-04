local M = {}

function M.setup()
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = 'rounded'
        opts.close_events = { 'CursorMoved', 'CursorMovedI', 'BufHidden', 'InsertCharPre', 'WinLeave' }
        opts.focus_id = 'cursor'
        opts.focusable = false
        opts.scope = 'cursor'

        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    function _G.lsp_dialog_hover()
        local bufnr = vim.diagnostic.open_float({
            scope = 'cursor',
            focusable = false,
            border = BORDER,
            close_events = {
                'CursorMoved',
                'CursorMovedI',
                'BufHidden',
                'InsertCharPre',
                'WinLeave',
            },
        })

        if bufnr == nil then
            vim.lsp.buf.hover()
        end
    end
end

function M.register_hover_cmd()
    -- Show diagnostics under the cursor when holding position
    vim.api.nvim_create_augroup('lsp_diagnostics_hold', { clear = true })

    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
        pattern = '*',
        command = [[silent! lua lsp_dialog_hover()]],
        group = 'lsp_diagnostics_hold',
    })
end

return M
