local function cokeline()
    local utils = require('cokeline.utils')

    local colors = {
        errors = {
            fg = utils.get_hex('DiagnosticError', 'fg'),
        },
        warnings = {
            fg = utils.get_hex('DiagnosticWarn', 'fg'),
        },
    }

    local default = {
        fg = function(buffer)
            return buffer.is_focussed and utils.get_hex('Normal', 'fg') or utils.get_hex('Comment', 'fg')
        end,

        bg = function(buffer)
            return buffer.is_focussed and utils.get_hex('Normal', 'bg') or utils.get_hex('ColorColumn', 'bg')
        end,
    }

    local components = {
        space = { text = ' ' },
        diagnostics = {
            text = function(buffer)
                return (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
                    or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
                    or ''
            end,
            hl = {
                fg = function(buffer)
                    return (buffer.diagnostics.errors ~= 0 and colors.errors.fg)
                        or (buffer.diagnostics.warnings ~= 0 and colors.warnings.fg)
                        or nil
                end,
            },
            truncation = { priority = 1 },
        },
    }
    require('cokeline').setup({
        show_if_buffers_are_at_least = 2,

        default_hl = {
            fg = default.fg,
            bg = 'NONE',
        },

        buffers = {
            focus_on_delete = 'prev',
            new_buffers_position = 'next',
        },

        --components = {
        --    components.space,
        --    components.diagnostics,
        --},
    })
end

local function lualine()
    require('lualine').setup({
        options = {
            icons_enabled = true,
            theme = 'tokyonight',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'NvimTree' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    })
end

local function scrollbar()
    local colors = require('tokyonight.colors').setup()

    require('scrollbar').setup({
        handle = { color = colors.bg_highlight },
        marks = {
            Search = { color = colors.orange },
            Error = { color = colors.error },
            Warn = { color = colors.warning },
            Info = { color = colors.info },
            Hint = { color = colors.hint },
            Misc = { color = colors.purple },
        },
    })
end

local function colorizer()
    require('colorizer').setup()
end

local function tree()
    -- vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

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
                    default = '',
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
            prefix = '[Filter  ]: ',
            always_show_folders = true,
        },
        filesystem_watchers = {
            enable = false,
            interval = 100,
            debounce_delay = 50,
        },
        remove_file = {
            close_window = true,
        },

        diagnostics = {
            enable = false,
            show_on_dirs = false,
            icons = {
                hint = '',
                info = '',
                warning = '',
                error = '',
            },
        },
    })

    vim.cmd([[set termguicolors]])
end

return {
    cokeline = cokeline,
    colorizer = colorizer,
    lualine = lualine,
    scrollbar = scrollbar,
    tree = tree,
}
