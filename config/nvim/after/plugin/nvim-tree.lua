local gheight = vim.api.nvim_list_uis()[1].height
local gwidth = vim.api.nvim_list_uis()[1].width

require('nvim-tree').setup({
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    on_attach = 'disable', -- function(bufnr). If nil, will use the deprecated mapping strategy
    view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 40,
        height = 30,
        hide_root_folder = true,
        side = 'right',
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        -- signcolumn = 'yes',
        -- @deprecated
        mappings = {
            custom_only = false,
            list = {
                { key = '<C-v>', action = 'vsplit' },
            },
        },
        float = {
            enable = true,
            open_win_config = {
                relative = 'editor',
                border = 'rounded',
                width = 40,
                height = gheight - 4,
                row = 0,
                col = gwidth - 40,
            },
        },
    },
    renderer = {
        highlight_git = true,
        highlight_opened_files = 'none',
        indent_width = 2,
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = '└',
                edge = '│',
                item = '│',
                bottom = '─',
                none = ' ',
            },
        },
        -- icons = { webdev_colors = true },
        special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
        symlink_destination = true,
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
    },
    ignore_ft_on_setup = {},
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        debounce_delay = 50,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
        },
    },
    filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
    },
    filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
    },
    git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        file_popup = {
            open_win_config = {
                col = 1,
                row = 1,
                relative = 'cursor',
                border = 'shadow',
                style = 'minimal',
            },
        },
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
                exclude = {
                    filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
                    buftype = { 'nofile', 'terminal', 'help' },
                },
            },
        },
        remove_file = {
            close_window = true,
        },
    },
    trash = {
        cmd = 'gio trash',
        require_confirm = true,
    },
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },
})

require('nvim-tree').on_enter()
