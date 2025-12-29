-- stylua: ignore
--[[========================== Jascha030's =============================--
--   __  __  __  __  ______                __       __  __  ______      --
--  /\ \/\ \/\ \/\ \/\__  _\   /'\_/`\    /\ \     /\ \/\ \/\  _  \     --
--  \ \ `\\ \ \ \ \ \/_/\ \/  /\      \   \ \ \    \ \ \ \ \ \ \L\ \    --
--   \ \ , ` \ \ \ \ \ \ \ \  \ \ \__\ \   \ \ \  __\ \ \ \ \ \  __ \   --
--    \ \ \`\ \ \ \_/ \ \_\ \__\ \ \_/\ \   \ \ \L\ \\ \ \_\ \ \ \/\ \  --
--     \ \_\ \_\ `\___/ /\_____\\ \_\\ \_\   \ \____/ \ \_____\ \_\ \_\ --
--      \/_/\/_/`\/__/  \/_____/ \/_/ \/_/    \/___/   \/_____/\/_/\/_/ --
--[[================ beep-beep-Config-2.0-beep-boop ====================]]
-- stylua: ignore end

-- Temporary fix: https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight
vim.g.mapleader = ' '

require('jascha030.globals')

-- Install required packages, if not already installed.
require('jascha030.core.bootstrap').install_packages({
    'folke/lazy.nvim',
    -- 'rktjmp/hotpot.nvim',
})

local lazy_opts = {
    -- Idea taken from `willothy/nvim-config` (https://github.com/willothy/nvim-config/blob/main/init.lua).
    {
        name = 'jascha030.init',
        main = 'jascha030',
        dir = vim.fn.stdpath('config') --[[@as string]],
        lazy = false,
        priority = 10000,
        opts = require('config'),
        config = function(_, opts)
            require('jascha030').setup(opts)
        end,
    },
    { import = 'plugins' },
}

if vim.loader then
    vim.loader.enable()

    -- if pcall(require, 'hotpot') then
    --     require('hotpot').setup({})
    -- end
    --
    -- table.insert(lazy_opts, 1, { 'rktjmp/hotpot.nvim' })
end

require('lazy').setup(lazy_opts, {
    concurrency = 5,
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'tarPlugin',
                'tohtml',
                'tutor',
            },
        },
    },
    ui = { border = BORDER },
})
