---@type LazyPluginSpec
return {
    'nickjvandyke/opencode.nvim',
    version = '*',
    dependencies = { 'folke/snacks.nvim' },
    event = 'VeryLazy',
    config = function()
        vim.o.autoread = true
    end,
    keys = {
        {
            '<leader>oa',
            function()
                require('opencode').ask('@this: ')
            end,
            mode = { 'n', 'x' },
            desc = 'Ask opencode',
        },
        {
            '<leader>os',
            function()
                require('opencode').select()
            end,
            mode = { 'n', 'x' },
            desc = 'Select opencode action',
        },
        {
            '<leader>oo',
            function()
                require('snacks.terminal').toggle('opencode --port', { win = { position = 'right', enter = true } })
            end,
            mode = { 'n', 't' },
            desc = 'Toggle opencode',
        },
        {
            'go',
            function()
                return require('opencode').operator('@this ')
            end,
            mode = { 'n', 'x' },
            desc = 'Add range to opencode',
            expr = true,
        },
        {
            'goo',
            function()
                return require('opencode').operator('@this ') .. '_'
            end,
            desc = 'Add line to opencode',
            expr = true,
        },
    },
}
