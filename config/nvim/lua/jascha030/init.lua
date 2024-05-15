local M = {}
local config = require('jascha030.core.config')

local function add_env_paths(paths)
    paths = paths or {}

    for _, path in pairs(paths) do
        vim.env.PATH = path .. ':' .. vim.env.PATH
    end
end

local function set_polyglot_lang_disables(languages)
    local all = vim.deepcopy(require('jascha030.utils.lang').get_langs(true))
    local disabled = {}

    for _, enabled in pairs(languages) do
        if all[enabled] ~= nil then
            all[enabled] = nil
        end
    end

    for _, lang in pairs(all) do
        table.insert(disabled, lang)
    end

    vim.g.polyglot_disabled = disabled
end

function M.get_config(key)
    return key == nil and config.options or config.get(key)
end

function M.setup(opts)
    config.setup(opts)

    add_env_paths(config.get('env').path)

    ---@diagnostic disable-next-line
    if config.get('polyglot').enabled then
        set_polyglot_lang_disables(config.get('polyglot').languages) ---@diagnostic disable-line
    end

    require('jascha030.core.keymaps').set_keymaps(config.get('keymaps'))
    require('jascha030.core.options').set_opts(config.get('opts'))

    -- Fix for the fact that n is bound to q, and I can't seem to find the source of this... :thinking_emoji:
    vim.keymap.set('n', 'n', 'n')
end

return setmetatable(M, {
    __index = function(_, key)
        if key == 'options' or key == 'opts' or key == 'config' then
            return config.options
        end

        return M.get_option(key)
    end,
})
