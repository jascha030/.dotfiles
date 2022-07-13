local M = {}

local util = require('util')
local kmap = util.kmap

local default_opts = { noremap = true }
local modes = { 'n', 'i', 'v', 't', 'x' }

local config = {
    default_opts = default_opts,
    maps = {
        ['n'] = {},
        ['i'] = {},
        ['v'] = {},
        ['t'] = {},
        ['x'] = {},
    },
}

-- todo compatibility for composed modes.
local function batch_map(type, opts)
    if not util.tbl_contains(modes, type) then
        error('Invalid mode: ' .. type)
    end

    for k, kopts in pairs(opts) do
        local a, o = kopts[1], kopts[2] or default_opts
        if k == nil or a == nil then
            error('Not enough arguments passed to keymap')
        end

        kmap(k, a, type, o or default_opts)
    end
end

function M.setup(userconfig)
    userconfig = userconfig or {}
    userconfig = vim.tbl_deep_extend('force', config, userconfig)
    for k, v in pairs(userconfig.maps) do
        batch_map(k, v)
    end
end

function M.map(keymap, action, opts) kmap(keymap, action, 'n', opts or default_opts) end
function M.imap(keymap, action, opts) kmap(keymap, action, 'i', opts or default_opts) end
function M.vmap(keymap, action, opts) kmap(keymap, action, 'v', opts or default_opts) end
function M.tmap(keymap, action, opts) kmap(keymap, action, 't', opts or default_opts) end
function M.xmap(keymap, action, opts) kmap(keymap, action, 'x', opts or default_opts) end

return M
