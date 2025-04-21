---@class DapPluginSpec: LazyPluginSpec
local M = {
    'mfussenegger/nvim-dap',
    lazy = true,
    cond = false,
    dependencies = {
        {
            'rcarriga/nvim-dap-ui',
            lazy = true,
            config = function()
                local dap = require('dap')
                local dapui = require('dapui')

                dapui.setup({ commented = true })

                dap.listeners.after.event_initialized['dapui_config'] = function()
                    dapui.open({})
                end

                dap.listeners.before.event_terminated['dapui_config'] = function()
                    dapui.close({})
                end

                dap.listeners.before.event_exited['dapui_config'] = function()
                    dapui.close({})
                end
            end,
        },
        { 'jayp0521/mason-nvim-dap.nvim', lazy = true },
        { 'theHamsta/nvim-dap-virtual-text', lazy = true },
        { 'nvim-telescope/telescope-dap.nvim', lazy = true },
    },
}

function M.config()
    local dap = require('dap')

    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '➡️', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '👀', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '🚨', texthl = '', linehl = '', numhl = '' })

    local bin_path = vim.fn.stdpath('data') .. '/mason/bin/'

    local mason_registry = require('mason-registry')
    local php_debugger = 'php-debug-adapter'

    if mason_registry.is_installed(php_debugger) then
        local adapter_path = bin_path .. php_debugger

        dap.adapters.php = {
            type = 'executable',
            command = 'bash',
            args = { adapter_path },
        }

        dap.configurations.php = {
            {
                name = 'Listen for Xdebug',
                type = 'php',
                request = 'launch',
                port = function()
                    local port
                    port = tonumber(vim.fn.input('Port [9003]: ')) or 9003
                    print('Debugging port ' .. port)
                    return port
                end,
            },
            {
                name = 'Launch currently open script',
                type = 'php',
                request = 'launch',
                program = '${file}',
                cwd = '${fileDirname}',
                port = 0,
                runtimeArgs = {
                    '-dxdebug.start_with_request=yes',
                },
                env = {
                    XDEBUG_MODE = 'debug,develop',
                    XDEBUG_CONFIG = 'client_port=${port}',
                },
            },
            {
                name = 'Launch Built-in web server',
                type = 'php',
                request = 'launch',
                runtimeArgs = {
                    '-dxdebug.mode=debug',
                    '-dxdebug.start_with_request=yes',
                    '-S',
                    'localhost:0',
                },
                program = '',
                cwd = '${workspaceRoot}',
                port = 9003,
                serverReadyAction = {
                    pattern = 'Development Server \\(http://localhost:([0-9]+)\\) started',
                    uriFormat = 'http://localhost:%s',
                    action = 'openExternally',
                },
            },
        }
    end
end

return {}
-- return M
