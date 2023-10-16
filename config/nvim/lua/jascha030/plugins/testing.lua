local M = {
    'nvim-neotest/neotest',
    cond = false,
    lazy = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'loganswartz/neotest-phpunit',
    },
}

function M.config()
    require('neotest').setup({
        adapters = {
            require('neotest-phpunit'),
        },
    })
end

return M
