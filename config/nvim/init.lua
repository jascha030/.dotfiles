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

BORDER = 'rounded'
BORDERS = { border = BORDER }

-- Temporary fix: https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight

if vim.loader then
    vim.loader.enable()
end

vim.g.mapleader = ' '

local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local lreq = require('jascha030.lreq')

_G.lreq = lreq

if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazy_path,
    })
end

vim.opt.runtimepath:prepend(lazy_path)

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
    ui = BORDERS,
})
