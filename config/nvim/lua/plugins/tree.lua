return function()
    vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

    require('nvim-tree').setup({
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        open_on_setup = false,
        open_on_tab = false,
        update_cwd = false,
        reload_on_bufenter = false,
        git = { ignore = false },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        view = {
            hide_root_folder = true,
            width = 40,
            height = 30,
            side = 'right',
            mappings = {
                custom_only = false,
                list = {
                    -- Should be default but wasn't working ¯\_(ツ)_/¯
                    { key = '<C-v>', action = 'vsplit' },
                },
            },
        },
        renderer = {
            highlight_git = true,
            icons = {
                webdev_colors = true,
                git_placement = 'before',
                padding = ' ',
                symlink_arrow = ' ➛ ',
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = '',
                    symlink = '',
                    folder = {
                        arrow_closed = '',
                        arrow_open = '',
                        default = '',
                        open = '',
                        empty = '',
                        empty_open = '',
                        symlink = '',
                        symlink_open = '',
                    },
                    git = {
                        unstaged = '✗',
                        staged = '✓',
                        unmerged = '',
                        renamed = '➜',
                        untracked = '★',
                        deleted = '',
                        ignored = '◌',
                    },
                },
            },
            special_files = {
                'Cargo.toml',
                'Makefile',
                'README.md',
                'readme.md',
                'composer.json',
                'package.json',
            },
        },
        filters = {
            exclude = {
                '.php-cs-fixer.cache',
                '.phpunit.result.cache',
            },
        },
        live_filter = {
            always_show_folders = true,
        },
        filesystem_watchers = {
            enable = false,
            debounce_delay = 50,
        },
        diagnostics = {
            enable = true,
            show_on_dirs = false,
            icons = {
                hint = '',
                info = '',
                warning = '',
                error = '',
            },
        },
    })
    require('nvim-tree').on_enter()
end
