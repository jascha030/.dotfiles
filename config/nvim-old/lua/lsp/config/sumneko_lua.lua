local util = require('utils')

local root = os.getenv('HOME') .. '/tools/lua-language-server'
local binary = root .. '/bin/lua-language-server'

-- workspace
local WS = {}

function WS.in_dotfiles()
    return util.cwd_in(vim.fn.expand('$DOTFILES'))
end

function WS.in_hammerspoon()
    return (util.cwd_in(vim.fn.expand('$HOME/.hammerspoon')) or WS.in_dotfiles())
end

function WS.in_neovim()
    return (util.cwd_in(vim.fn.stdpath('config')) or WS.in_dotfiles())
end

function WS.in_wez()
    return (util.cwd_in(vim.fn.expand('$HOME/.hammerspoon')) or WS.in_dotfiles())
end

local M = {}

function M.path()
    local path = WS.in_neovim() and vim.split(package.path, ';') or {}

    for _, p in
        ipairs({
            'lua/?.lua',
            'lua/?/init.lua',
        })
    do
        table.insert(path, p)
    end

    return path
end

function M.library()
    --local ret = vim.api.nvim_get_runtime_file('', true)
    local ret = {}

    local function add(lib, filter)
        for _, p in pairs(vim.fn.expand(lib, false, true)) do
            p = vim.loop.fs_realpath(p)

            if p and (not filter or filter[vim.fn.fnamemodify(p, ':h:t')]) then
                table.insert(ret, p)
            end
        end
    end

    if WS.in_dotfiles() then
        add('$VIMRUNTIME/lua')
        add('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs')
        add('$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations')
        add('$WEZTERM_CONFIG_DIR')
    end

    if WS.in_neovim() then
        add('$VIMRUNTIME/lua')
    end

    if WS.in_hammerspoon() then
        add('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs')
        add('$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations')
    end

    if WS.in_wez() then
        add('$WEZTERM_CONFIG_DIR')
    end

    return ret
end

function M.version()
    local ret = { 'LuaJIT' }

    if util.tbl_length(ret) == 1 then
        return 'LuaJIT'
    end

    return ret
end

function M.globals()
    local ret = {}

    local available_globals = {
        ['vim'] = WS.in_neovim(),
        ['hs'] = WS.in_hammerspoon(),
    }

    for gv, f in pairs(available_globals) do
        if f then
            table.insert(ret, gv)
        end
    end

    return ret
end

--local hs_path = vim.split(vim.fn.system('hs -c package.path'):gsub('[\n\r]', ''), ';')

local config = {
    cmd = { binary, '-E', root .. '/main.lua' },
    settings = {
        Lua = {
            runtime = {
                version = M.version(),
                maxPreload = 1000,
                preloadFileSize = 150,
            },
            diagnostics = {
                globals = M.globals(),
            },
            workspace = {
                library = M.library(),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

return config
