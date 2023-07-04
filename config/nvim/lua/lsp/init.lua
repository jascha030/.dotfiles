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
        -- for _, window_id in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            -- local win_conf = vim.api.nvim_win_get_config(window_id)
        -- end

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

return M
