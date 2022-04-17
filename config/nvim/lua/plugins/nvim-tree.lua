vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

local git = { unstaged = '', staged = '✓', unmerged = '', renamed = '➜', untracked = '' }
local folder = { default = '', open = '', empty = '', empty_open = '', symlink = '' }

local icons = {
    hint = '',
    info = '',
    warning = '',
    error = '',
    default = '',
    symlink = '',
    git = git,
    folder = folder,
}

require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    open_on_setup = false,
    open_on_tab = false,
    update_cwd = false,

    ignore_ft_on_setup = {},

    update_to_buf_dir = {
        enable = true,
        auto_open = true,
    },

    diagnostics = {
        enable = false,
        icons = icons,
    },

    git = { ignore = false },

    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
    },

    system_open = {
        cmd = nil,
        args = {},
    },

    view = {
        hide_root_folder = true,
        width = 40,
        height = 30,
        side = 'right',
        auto_resize = false,
        mappings = {
            custom_only = false,
            list = {
                -- Should be default but wasn't working ¯\_(ツ)_/¯
                { key = '<C-v>', action = 'vsplit' },
            },
        },
    },

    filters = { exclude = { '.php-cs-fixer.cache', '.phpunit.result.cache' } },
})

vim.cmd([[set termguicolors]])
