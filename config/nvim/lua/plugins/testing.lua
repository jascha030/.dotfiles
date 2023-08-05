return {
    {
        'nvim-neotest/neotest',
        cond = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'loganswartz/neotest-phpunit',
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-phpunit'),
                },
            })
        end,
    },
}
