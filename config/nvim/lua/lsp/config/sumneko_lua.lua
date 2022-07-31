local util = require('util')
local path = require('lua.plenary.path')

local sumneko_root_path = os.getenv('HOME') .. '/tools/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/lua-language-server'
local runtime_path = vim.split(package.path, ';')
local library = vim.api.nvim_get_runtime_file('', true)


local config = {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
        Lua = {
            runtime = {
                version = 'LUAJIT',
                path = {},
            },
            diagnostics = {
                globals = { 'hs', 'vim' },
            },
            workspace = {
                library = {},
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

local hs = {
    version = vim.fn.system('hs -c _VERSION'):gsub('[\n\r]', ''),
    path = vim.split(vim.fn.system('hs -c package.path'):gsub('[\n\r]', ''), ';'),
}

-- Wildcards
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Merge runtime_path with hammerspoon paths
runtime_path = util.tbl_merge(runtime_path, hs.path)
library = util.tbl_merge(library, {
    vim.fn.expand('$VIMRUNTIME/lua'),
    vim.fn.expand('$WEZTERM_CONFIG_DIR'),
    vim.fn.expand('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs'),
    vim.fn.expand('$DOTFILES/config/nvim/EmmyLua/'),
    vim.fn.expand('$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations'),
})

return config
