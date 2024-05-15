local M = {
    'stevearc/dressing.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    event = 'VeryLazy',
    opts = {
        input = {
            -- When true, <Esc> will close the modal - Defaults to true
            insert_only = false,
        },
    },
}

function M.init()
    ---@diagnostic disable-next-line: duplicate-set-field different-requires
    vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })

        return vim.ui.select(...)
    end

    ---@diagnostic disable-next-line: duplicate-set-field different-requires
    vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })

        return vim.ui.input(...)
    end
end

return M
