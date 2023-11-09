local M = {
    'stevearc/dressing.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    event = 'VeryLazy',
}

function M.opts()
    -- return {
    --     select = {
    --         get_config = function(opts)
    --             if opts.kind == 'codeaction' then
    --                 return {
    --                     backend = 'nui',
    --                     nui = {
    --                         relative = 'editor',
    --                         max_width = 40,
    --                     },
    --                 }
    --             end
    --         end,
    --     },
    -- }
end

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
