local utils = require('utils')

local function path()
    local path = utils.fs.in_neovim() and vim.split(package.path, ';') or {}

    for _, p in ipairs({
        'lua/?.lua',
        'lua/?/init.lua',
    }) do
        table.insert(path, p)
    end

    return path
end

local function library(opts)
    local ret = {}

    local function add(lib, filter)
        for _, p in pairs(vim.fn.expand(lib .. '/lua', false, true)) do
            p = vim.loop.fs_realpath(p)

            if p and (not filter or filter[vim.fn.fnamemodify(p, ':h:t')]) then
                table.insert(ret, p)
            end
        end
    end

    local function add_plugins(plugins)
        local filter = {}

        for _, p in pairs(plugins) do
            filter[p] = true
        end

        for _, site in pairs(vim.split(vim.o.packpath, ',')) do
            add(site .. '/pack/*/opt/*', {})
            add(site .. '/pack/*/start/*', {})
        end
    end

    if utils.fs.in_neovim() then
        add('$VIMRUNTIME')
        add('$HOME/.local/share/nvim/site/pack/packer/opt/lua-dev.nvim/types')

        add_plugins(opts or {})
    end

    if utils.fs.in_hammerspoon() then
        add('$HOME/.hammerspoon/hs')
        add('$HOME/.hammerspoon/Spoons')
        add('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs')
        add('$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations')
    end

    if utils.fs.in_wez() then
        add('$WEZTERM_CONFIG_DIR')
    end

    return ret
end

local function version()
    local ret = { 'LuaJIT' }

    if utils.tbl.tbl_length(ret) == 1 then
        return 'LuaJIT'
    end

    return ret
end

local function globals()
    local ret = {}

    local available_globals = {
        ['vim'] = utils.fs.in_neovim(),
        ['hs'] = utils.fs.in_hammerspoon(),
    }

    for gv, f in pairs(available_globals) do
        if f then
            table.insert(ret, gv)
        end
    end

    return ret
end

local root = os.getenv('HOME') .. '/tools/lua-language-server'
local binary = root .. '/bin/lua-language-server'
local plugins = require('config').lsp.sumneko_lua.plugins

return {
    cmd = { binary, '-E', root .. '/main.lua' },
    settings = {
        Lua = {
            runtime = {
                version = version(),
                maxPreload = 1000,
                path = path(),
                preloadFileSize = 150,
            },
            diagnostics = { globals = globals() },
            workspace = {
                library = library(plugins),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}
