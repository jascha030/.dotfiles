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

require('core.globals')
require('core.bootstrap').install_packages({ 'folke/lazy.nvim' }) -- Install required packages, if not already installed.
require('core.filetypes')

if vim.loader then
    vim.loader.enable()
end

require('lazy').setup({
    spec = {
        {
            name = 'jascha030',
            dir = vim.fn.stdpath('config') --[[@as string]],
            lazy = false,
            priority = 10000,
            opts = {
                debug = false,
                path = {
                    env = { vim.env.HOME .. '/.local/share/mise/shims' },
                    rtp = { { path = '/Applications/Ghostty.app/Contents/Resources/vim/vimfiles', prepend = true } },
                },
                colorscheme = 'nitepal',
            },
        },
        {
            name = 'config',
            dir = vim.fn.stdpath('config') --[[@as string]],
            lazy = false,
            dependencies = { 'jascha030' },
        },
        { import = 'plugins' },
    },
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
