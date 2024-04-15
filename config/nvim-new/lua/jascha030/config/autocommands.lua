local M = {}

local function build_opts(def, group)
    local opts = vim.deepcopy(def)
    opts.event = nil
    opts.group = group or nil
    return opts
end

function M.nvim_create_augroups(groups)
    for group_name, definitions in pairs(groups) do
        local group = vim.api.nvim_create_augroup(group_name, { clear = true })

        for _, def in ipairs(definitions) do
            vim.api.nvim_create_autocmd(def.event, build_opts(def, group))
        end
    end
end

function M.nvim_create_augroups_legacy(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')

        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
            vim.api.nvim_command(command)
        end

        vim.api.nvim_command('augroup END')
    end
end

return M
