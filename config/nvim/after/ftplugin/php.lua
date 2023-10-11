if vim.g.phpactor_picker_loaded == nil then
    vim.cmd([[command PhpactorTelescope :lua require('jascha030.utils.php.phpactor-telescope').picker()]])

    vim.keymap.set('i', '<C-p>', '<cmd>PhpactorTelescope<CR>')
    vim.g.phpactor_picker_loaded = true
end

-- local M = {}
--
-- function M.dap()
--     local dap = require('dap')
--
--     dap.adapters.php = {
--         type = 'executable',
--         command = 'node',
--         args = { '/Users/jaschavanaalst/.config/dap/vscode-php-debug/out/phpDebug.js' },
--     }
--
--     dap.configurations.php = {
--         {
--             type = 'php',
--             request = 'launch',
--             name = 'Listen for xdebug',
--             port = '9003',
--             pathMappings = {
--                 ['/var/www/html'] = '${workspaceFolder}/app/public',
--             },
--         },
--     }
--
--     vim.api.nvim_exec([[au FileType dap-repl lua require('dap.ext.autocompl').attach()]], false)
--     vim.keymap.set('n', '<leader>d', [[<cmd>:DapToggleRepl<CR>]], { silent = true })
--     vim.keymap.set('n', 'DD', [[<cmd>:DapToggleBreakpoint<CR>]], { silent = true })
--
--     require('nvim-dap-virtual-text').setup()
--     require('dapui').setup()
-- end
--

