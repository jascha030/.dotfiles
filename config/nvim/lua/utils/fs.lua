local M = {}

M.data_dir = string.format('%s/site', vim.fn.stdpath('data'));

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
    return (M.cwd_in(vim.fn.stdpath('config')) or M.in_dotfiles())
end

function M.in_wez()
    return (M.cwd_in(vim.fn.expand('$HOME/.hammerspoon')) or M.in_dotfiles())
end

return M
