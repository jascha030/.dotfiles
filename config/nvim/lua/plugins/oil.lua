-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require('oil').get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ':~')
    else
        return vim.api.nvim_buf_get_name(0) -- If there is no current directory (e.g. over ssh), just show the buffer name
    end
end

return {
    'stevearc/oil.nvim',
    opts = function()
        local detail = false

        ---@module 'oil'
        ---@type oil.SetupOpts
        return {
            win_options = {
                winbar = '%!v:lua.get_oil_winbar()',
            },
            keymaps = {
                ['gd'] = {
                    desc = 'Toggle file detail view',
                    callback = function()
                        detail = not detail

                        if detail then
                            require('oil').set_columns({ 'icon', 'permissions', 'size', 'mtime' })
                        else
                            require('oil').set_columns({ 'icon' })
                        end
                    end,
                },
            },
        }
    end,
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    lazy = false,
}
