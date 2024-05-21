-- local lreq = require('jascha030.lreq')
local Config = require('jascha030.core.config')

local M = {}

---@param k string|nil Config key
function M.get_config(k)
    if k == nil then
        return Config.options
    end

    return Config.get(k)
end

function M.setup(opts)
    local function add_env_paths(paths)
        paths = paths or {}
        for _, path in pairs(paths) do
            vim.env.PATH = path .. ':' .. vim.env.PATH
        end
    end

    local function set_polyglot_lang_disables(languages)
        local disabled = {}
        local all = vim.deepcopy(require('jascha030.utils.lang').get_langs(true))

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

    Config.setup(opts)

    ---@diagnostic disable-next-line: undefined-field
    local path_conf = Config.get('env').path

    add_env_paths(path_conf)

    ---@diagnostic disable-next-line
    if Config.get('polyglot').enabled then
        set_polyglot_lang_disables(Config.get('polyglot').languages) ---@diagnostic disable-line
    end

    require('jascha030.core.keymaps').set_keymaps(Config.get('keymaps'))
    require('jascha030.core.options').set_opts(Config.get('opts'))
end

return M
