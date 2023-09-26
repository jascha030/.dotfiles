-- @type Utils utils
local utils = require('jascha030.utils')

local function paths()
    local path = utils.fs.in_neovim() and vim.split(package.path, ';') or {}

    for _, p in ipairs({
        'lua/?.lua',
        'lua/?/init.lua',
    }) do
        table.insert(path, p)
    end

    return path
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

require('neodev').setup({})

return {
    cmd = { binary, '-E', root .. '/main.lua' },
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            runtime = {
                version = version(),
                maxPreload = 1000,
                path = paths(),
                preloadFileSize = 150,
            },
            diagnostics = {
                globals = globals(),
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.fn.stdpath('data') .. '/lazy/emmylua-nvim',
                    vim.fn.stdpath('config'),
                }
            },
            telemetry = { enable = false },
        },
    },
}
