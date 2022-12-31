local scopes = {
    g = vim.g,
    o = vim.o,
    b = vim.bo,
    bo = vim.bo,
    w = vim.wo,
    wo = vim.wo,
}

local default = {
    colorscheme = false,
    keymaps = {},
    plugin_configs = {},
    options = { g = { mapleader = [[ ]] }, opt = {} },
    devicons = { icons = {}, overrides = {} },
}

local config = nil
local setup = false

local function init()
    if type(config) == 'table' then
        return
    end

    config = vim.tbl_deep_extend('force', default, require('config'))
end

local function opt(key, val, scope)
    if not scope then
        vim.opt[key] = val
    else
        scopes[scope][key] = val
    end
end

local Conf = setmetatable({}, {
    __index = function(_, key)
        init()
        return config[key]
    end,
})

local function _setup()
    -- vim.o.runtimepath = vim.o.runtimepath .. ',' .. os.getenv('XDG_CONFIG_HOME')
    local map = vim.api.nvim_set_keymap
    local default_m_opts = { noremap = true }

    for scope, opts in pairs(Conf.options) do
        for o, v in pairs(opts) do
            if scope == 'opt' then
                opt(o, v)
            else
                opt(o, v, scope)
            end
        end
    end

    for mtype, tmaps in pairs(Conf.keymaps) do
        for kmap, args in pairs(tmaps) do
            local a, o = args[1], args[2] or default_m_opts
            map(mtype, kmap, a, o)
        end
    end
end

function Conf.setup()
    if setup then
        return
    end

    setup = true
    _setup()
end

return Conf
