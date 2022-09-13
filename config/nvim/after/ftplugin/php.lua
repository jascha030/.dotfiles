local dap = require('dap')

vim.g.gitblame_display_virtual_text = 1

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/Users/jaschavanaalst/.config/dap/vscode-php-debug/out/phpDebug.js' },
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for xdebug',
        port = '9003',
        pathMappings = {
            ['/var/www/html'] = '${workspaceFolder}/app/public',
        },
    },
}

vim.api.nvim_exec([[au FileType dap-repl lua require('dap.ext.autocompl').attach()]], false)
vim.keymap.set('n', '<leader>d', [[<cmd>:DapToggleRepl<CR>]], { silent = true })
vim.keymap.set('n', 'DD', [[<cmd>:DapToggleBreakpoint<CR>]], { silent = true })

require('nvim-dap-virtual-text').setup()
require('dapui').setup()
