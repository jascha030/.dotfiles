---@type LazyPluginSpec
local M = {
    'nvim-neotest/neotest',
    -- cond = false,
    lazy = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'loganswartz/neotest-phpunit',
    },
}

function M.config()
    local neotest_ns = vim.api.nvim_create_namespace('neotest')

    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
                return message
            end,
        },
    }, neotest_ns)

    require('neotest').setup({
        adapters = {
            require('neotest-phpunit'),
        },
    })

    vim.api.nvim_create_user_command("NeotestRun", function()
        require("neotest").run.run()
    end, {})
    vim.api.nvim_create_user_command("NeotestRunCurrent", function()
        require("neotest").run.run(vim.fn.expand("%"))
    end, {})
    vim.api.nvim_create_user_command("NeotestRunDap", function()
        require("neotest").run.run({ strategy = "dap" })
    end, {})
    vim.api.nvim_create_user_command("NeotestStop", function()
        require("neotest").run.stop()
    end, {})
    vim.api.nvim_create_user_command("NeotestAttach", function()
        require("neotest").run.attach()
    end, {})
    vim.api.nvim_create_user_command("NeotestOutput", function()
        require("neotest").output.open()
    end, {})
    vim.api.nvim_create_user_command("NeotestSummary", function()
        require("neotest").summary.toggle()
    end, {})
end

return M
