require'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    update_to_buf_dir   = {
        enable = true,
        auto_open = true,
    },
    auto_close          = true,
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    diagnostics         = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
            default = '',
            symlink = '',
            git = {
                unstaged = "", 
                staged = "✓", 
                unmerged = "", 
                renamed = "➜", 
                untracked = ""
            },
            folder = {
                default = "", 
                open = "", 
                empty = "", 
                empty_open = "", 
                symlink = ""
            }
        }
    },
    update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    view = {
        width = 30,
        height = 30,
        side = 'right',
        auto_resize = false,
        mappings = {
            custom_only = false,
            list = {}
        }
    }
}

vim.cmd('set termguicolors')

