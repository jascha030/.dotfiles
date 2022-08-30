local config = nil
local setup = false
local default = {
    colorscheme = false,
    options = {
        g = { mapleader = [[ ]] },
        opt = {},
    },
    keymaps = {},
    devicons = require('utils').icons.defaults,
}

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
    local utils = require('utils')
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

    if Conf.colorscheme == 'nitepal' then
        require('utils').theme.init()
    else
        vim.cmd('colorscheme ' .. Conf.colorscheme)
    end

    require('lsp').init()

    utils.plugin.create_cmds()
    utils.icons.setup(Conf.devicons)
end

function Conf.setup()
    if setup then
        return
    end

    setup = true
    _setup()
end

return Conf
