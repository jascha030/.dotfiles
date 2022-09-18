local utils = require('utils')

local default = {
    colorscheme = false,
    options = {
        g = { mapleader = [[ ]] },
        opt = {},
    },
    keymaps = {},
    devicons = require('utils').icons.defaults,
    plugin_configs = {}
}

local config = nil
local setup = false

local function init()
    if type(config) == 'table' then
        return
    end

    config = vim.tbl_deep_extend('force', default, require('config'))
end


local Conf = setmetatable({}, {
    __index = function(_, key)
        init()
        return config[key]
    end,
})

local function _setup()
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. os.getenv('XDG_CONFIG_HOME')

    local map = vim.api.nvim_set_keymap
    local default_m_opts = { noremap = true }

    for scope, opts in pairs(Conf.options) do
        for o, v in pairs(opts) do
            if scope == 'opt' then
                utils.opt(o, v)
            else
                utils.opt(o, v, scope)
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
