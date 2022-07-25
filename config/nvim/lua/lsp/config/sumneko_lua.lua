local util = require('util')

-- Language server paths
local binary_path = vim.fn.exepath('lua-language-server')
-- Loaded runtime package paths
local runtime_path = vim.split(package.path, ';')

-- Hammerspoon runtime
local hs_version = vim.fn.system('hs -c _VERSION'):gsub('[\n\r]', '')
local hs_path = vim.split(vim.fn.system('hs -c package.path'):gsub('[\n\r]', ''), ';')

-- Wildcards
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Merge runtime_path with hammerspoon paths
runtime_path = util.tbl_merge(runtime_path, hs_path)

-- Merge Neovim runtime with other libraries
local library = vim.api.nvim_get_runtime_file('', true)

library = util.tbl_merge(library, {
    vim.fn.expand('$WEZTERM_CONFIG_DIR'),
    vim.fn.expand('$VIMRUNTIME/lua'),
    vim.fn.expand('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'),
    vim.fn.expand('$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations'),
})

return {
    settings = {
        Lua = {
            runtime = {
                version = {
                    'LuaJIT',
                    hs_version,
                },
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'hs', 'vim' },
            },
            workspace = {
                library = library,
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
