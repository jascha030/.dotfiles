local M = {}

function M.unload(mod)
    if not package.loaded[mod] then
        return
    end

    package.loaded[mod] = nil
end

function M.resolve_config(mod)
    local ok, config = pcall(require, 'config.' .. mod)

    return ok and config or nil
end

local function attempt_plugin_setup(mod, config)
    local res = nil
    local ok, plugin = pcall(require, mod)

    if not ok then
        return false, res
    end

    M.unload(mod)

    if config == nil then
        return pcall(plugin.setup)
    else
        return pcall(plugin.setup, config)
    end
end

function M.load(mod, config)
    config = config or M.resolve_config(mod)

    if type(config) == 'function' then
        return pcall(config)
    end

    if type(config) == 'table' or type(config) == 'nil' then
        return attempt_plugin_setup(mod, config)
    end

    error('Invalid config for: "' .. mod .. '".')
end

function M.load_all(opts)
    opts = opts or { 'nvim-web-devicons' }

    local contains = require('utils.tbl').tbl_contains

    local dir = vim.fn.stdpath('config') .. '/lua/config/'
    local exclude = { init = true, loader = true }

    if dir and string.sub(dir, 1, 1) == '@' then
        dir = string.sub(dir, 2)
    end

    local handle = vim.loop.fs_scandir(dir)

    if not handle then
        error('Could not load plugin config listing.')
    end

    local ret = {}
    local name, typ, req, ext

    while handle do
        name, typ = vim.loop.fs_scandir_next(handle)

        if not name then
            break
        end

        ext = vim.fn.fnamemodify(name, ':e')
        req = vim.fn.fnamemodify(name, ':r')

        if ext == 'lua' and typ == 'file' and not exclude[req] then
            if contains(opts, req) then
                M.load(req)
            else
                table.insert(ret, req)
            end
        end
    end

    for _, m in pairs(ret) do
        M.load(m)
    end
end

return M
