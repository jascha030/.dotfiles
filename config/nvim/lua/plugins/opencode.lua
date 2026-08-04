---@type LazyPluginSpec
return {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    event = 'VeryLazy',
    config = function()
        local opencode_cmd = 'opencode --port'
        local snacks_terminal_opts = {
            win = {
                position = 'right',
                enter = false,
            },
        }

        ---@type opencode.Opts
        vim.g.opencode_opts = {
            lsp = {
                enabled = true,
            },
            server = {
                start = function()
                    require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
                end,
            },
        }

        vim.o.autoread = true

        vim.api.nvim_create_autocmd('User', {
            pattern = { 'OpencodeEvent:tui.command.execute' },
            callback = function(args)
                local event = args.data.event
                if event.properties.command == 'prompt.submit' then
                    local win = require('snacks.terminal').get(opencode_cmd, { create = false })
                    if win then
                        win:show()
                    end
                end
            end,
        })
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
                require('snacks.terminal').toggle('opencode --port', {
                    win = {
                        position = 'right',
                        enter = true,
                    },
                })
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
