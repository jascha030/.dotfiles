local M = {}

---@param opts table
function M.setup(opts)
    if opts.debug == true then
        vim.lsp.log.set_log_level('debug')
    end

    local path_helper = {}

    ---@param p string|table
    function path_helper.prepend(p)
        return type(p) == 'table' and p.prepend ~= nil and p.prepend == true
    end

    ---@param p string|table
    function path_helper.get_path_string(p)
        if type(p) == 'string' then
            return p
        end

        if type(p) == 'table' then
            return p.path
        end

        error('Invalid path type')
    end

    ---@param p string|table
    ---@param t string
    function path_helper.add(p, t)
        local path_string = path_helper.get_path_string(p)

        if t == 'env' then
            if path_helper.prepend(p) then
                vim.env.PATH = path_string .. ':' .. vim.env.PATH
            else
                vim.env.PATH = vim.env.PATH .. ':' .. path_string
            end
        end

        if t == 'rtp' then
            if path_helper.prepend(p) then
                vim.opt.runtimepath:prepend(path_string)
            else
                vim.opt.runtimepath:append(path_string)
            end
        end
    end

    ---@param paths table
    local function add_paths(paths)
        paths = paths or {}
        for type, type_paths in pairs(paths) do
            for _, path in pairs(type_paths) do
                path_helper.add(path, type)
            end
        end
    end

    add_paths(opts.path)
end

return M
