---@class jascha030.core.Autocmds
---@field nvim_create_augroups fun(groups: table): nil
---@field nvim_create_augroups_legacy fun(definitions: table): nil
local M = {}

---@param def table
---@param group string|integer
---@return table
local function build_opts(def, group)
    local opts = vim.deepcopy(def)
    opts.event = nil
    opts.group = group or nil

    return opts
end

---@param groups table
function M.nvim_create_augroups(groups)
    for group_name, definitions in pairs(groups) do
        local group = vim.api.nvim_create_augroup(group_name, { clear = true })

        for _, def in ipairs(definitions) do
            vim.api.nvim_create_autocmd(def.event, build_opts(def, group))
        end
    end
end

---@param definitions table
function M.nvim_create_augroups_legacy(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')

        for _, def in ipairs(definition) do
            local command = table.concat(vim.iter({ 'autocmd', def }):flatten():totable(), ' ')
            vim.api.nvim_command(command)
        end

        vim.api.nvim_command('augroup END')
    end
end

return M
