local Config = require('jascha030.core.config')

local M = {}

---@param k string|nil Config key
function M.get_config(k)
    if k == nil then
        return Config.options
    end

    return Config.get(k)
end

---@param opts jascha030.core.config.ConfigOptions
---@return nil|string|table
function M.setup(opts)
    if opts.debug == true then
        vim.lsp.log.set_log_level('debug')
    end

    local path_helper = {}

    ---@param p jascha030.core.config.PathConfigOption
    function path_helper.prepend(p)
        return type(p) == 'table' and p.prepend ~= nil and p.prepend == true
    end

    ---@param p jascha030.core.config.PathConfigOption
    function path_helper.get_path_string(p)
        if type(p) == 'string' then
            return p
        end

        if type(p) == 'table' then
            return p.path
        end

        error('Invalid path type')
    end

    ---@param p jascha030.core.config.PathConfigOption
    ---@param type jascha030.core.config.PathConfigOptionType
    function path_helper.add(p, type)
        local path_string = path_helper.get_path_string(p)

        if type == 'env' then
            if path_helper.prepend(p) then
                vim.env.PATH = path_string .. ':' .. vim.env.PATH
            else
                vim.env.PATH = vim.env.PATH .. ':' .. path_string
            end
        end

        if type == 'rtp' then
            if path_helper.prepend(p) then
                vim.opt.runtimepath:prepend(path_string)
            else
                vim.opt.runtimepath:append(path_string)
            end
        end
    end

    ---@param paths jascha030.core.config.PathConfigOptions
    local function add_paths(paths)
        paths = paths or {}
        for type, type_paths in pairs(paths) do
            for _, path in pairs(type_paths) do
                path_helper.add(path, type)
            end
        end
    end

    Config.setup(opts)

    ---@diagnostic disable-next-line: undefined-field
    local path = Config.get('path') or {}
    add_paths(path)

    require('jascha030.core.keymaps').set_keymaps(Config.get('keymaps') or {})
    require('jascha030.core.options').set_opts(Config.get('opts') --[[@as table]])

    vim.keymap.set(
        '',
        '<Esc>',
        '<cmd>noh<cr><Esc>',
        { desc = 'clears search highlights', noremap = true, silent = true }
    )
end

return M
