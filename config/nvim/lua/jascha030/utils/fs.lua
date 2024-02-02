--- @class FilesystemHelpers
--- @field data_dir string stdpath 'data'
local M = {}

M.data_dir = string.format('%s/site', vim.fn.stdpath('data'))

function M.cwd_in(where)
    return string.find(vim.fn.getcwd(), where) ~= nil
end

function M.in_dotfiles()
    return M.cwd_in(vim.fn.expand('$DOTFILES'))
end

function M.in_hammerspoon()
    return (M.cwd_in(vim.fn.expand('$HOME/.hammerspoon')) or M.in_dotfiles())
end

function M.in_neovim()
    return (
        M.cwd_in(vim.fn.stdpath('config'))
        or M.in_dotfiles()
        or M.cwd_in(vim.fn.expand('$HOME/.development/Projects/Lua/nitepal.nvim'))
    )
end

function M.in_wez()
    return (M.cwd_in(vim.fn.expand('$HOME/.hammerspoon')) or M.in_dotfiles())
end

function M.file_picker()
    if require('lazy.util').file_exists(vim.fn.getcwd() .. '/.git') then
        require('telescope.builtin').git_files()
    else
        require('telescope.builtin').find_files()
    end
end

return M
