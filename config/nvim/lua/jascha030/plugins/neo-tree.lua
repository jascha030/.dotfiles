---@type LazyPluginSpec
local M = {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
    },
    opts = {
        sources = {
            'filesystem',
            'buffers',
            'git_status',
            'document_symbols',
        },
        add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
        close_if_last_window = true,
        default_source = 'filesystem',
        enable_diagnostics = true,
        enable_git_status = true,
        enable_modified_markers = true, -- Show markers for files with unsaved changes.
        enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
        enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
        git_status_async = true,
        hide_root_node = false,
        retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
        open_files_in_last_window = true, -- false = open files in top left window
        open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'edgy' },
        popup_border_style = BORDER, -- "double", "none", "rounded", "shadow", "single" or "solid"
        resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil,
        use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
        use_default_mappings = true,
        -- source_selector provides clickable tabs to switch between sources.
        source_selector = {
            winbar = false,
            statusline = false,
            show_scrolled_off_parent_node = true, -- this will replace the tabs with the parent path
            sources = {
                { source = 'filesystem' },
                { source = 'buffers' },
                { source = 'git_status' },
            },
            -- content_layout = 'start', -- only with `tabs_layout` = "equal", "focus"
            -- tabs_layout = 'equal', -- start, end, center, equal, focus
            -- truncation_character = '…', -- character to use when truncating the tab label
            -- tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
            -- tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
            -- padding = 0, -- can be int or table
            -- separator = { left = '▏', right = '▕' },
            -- separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
            -- show_separator_on_edge = false,
            -- highlight_tab = 'NeoTreeTabInactive',
            -- highlight_tab_active = 'NeoTreeTabActive',
            -- highlight_background = 'NeoTreeTabInactive',
            highlight_separator = 'NeoTreeTabSeparatorInactive',
            highlight_separator_active = 'NeoTreeTabSeparatorActive',
        },
        default_component_configs = {
            container = {
                enable_character_fade = true,
                width = '100%',
                right_padding = 0,
            },
            indent = {
                indent_size = 2,
                padding = 1,
                -- indent guides
                with_markers = true,
                indent_marker = '│',
                last_indent_marker = '└',
                highlight = 'NeoTreeIndentMarker',
                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = '',
                expander_expanded = '',
                expander_highlight = 'NeoTreeExpander',
            },
            icon = {
                folder_closed = '',
                folder_open = '',
                folder_empty = '',
                folder_empty_open = '',
                -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                default = '*',
                highlight = 'NeoTreeFileIcon',
            },
            modified = {
                symbol = '[+] ',
                highlight = 'NeoTreeModified',
            },
            name = {
                trailing_slash = false,
                highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
                use_git_status_colors = true,
                highlight = 'NeoTreeFileName',
            },
            git_status = {
                symbols = {
                    -- Change type
                    added = '✚', -- NOTE: you can set any of these to an empty string to not show them
                    deleted = '✖',
                    modified = '',
                    renamed = '',
                    -- Status type
                    untracked = '',
                    ignored = '',
                    unstaged = '',
                    staged = '',
                    conflict = '',
                },
                align = 'right',
            },
        },
        window = {
            position = 'right',
            auto_expand_width = false,
            mapping_options = { noremap = true, nowait = true },
            mappings = {
                ['<space>'] = { 'toggle_node', nowait = false },
                ['<2-LeftMouse>'] = 'open',
                ['<cr>'] = 'open',
                ['<esc>'] = 'revert_preview',
                ['P'] = { 'toggle_preview', config = { use_float = true } },
                ['l'] = 'focus_preview',
                ['S'] = 'open_split',
                -- ["S"] = "split_with_window_picker",
                ['s'] = 'open_vsplit',
                -- ["s"] = "vsplit_with_window_picker",
                ['t'] = 'open_tabnew',
                -- ["<cr>"] = "open_drop",
                -- ["t"] = "open_tab_drop",
                ['w'] = 'open_with_window_picker',
                ['C'] = 'close_node',
                ['z'] = 'close_all_nodes',
                --["Z"] = "expand_all_nodes",
                ['R'] = 'refresh',
                ['a'] = { 'add', config = { show_path = 'none' } },
                ['A'] = 'add_directory', -- also accepts the config.show_path and config.insert_as options.
                ['d'] = 'delete',
                ['r'] = 'rename',
                ['y'] = 'copy_to_clipboard',
                ['x'] = 'cut_to_clipboard',
                ['p'] = 'paste_from_clipboard',
                ['c'] = 'copy', -- takes text input for destination, also accepts the config.show_path and config.insert_as options
                ['m'] = 'move', -- takes text input for destination, also accepts the config.show_path and config.insert_as options
                ['e'] = 'toggle_auto_expand_width',
                ['q'] = 'close_window',
                ['?'] = 'show_help',
                ['<'] = 'prev_source',
                ['>'] = 'next_source',
            },
        },
        filesystem = {
            bind_to_cwd = false, -- true creates a 2-way binding between vim's cwd and neo-tree's root
            filtered_items = {
                visible = false, -- when true, they will just be displayed differently than normal items
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_by_name = {
                    '.DS_Store',
                    'thumbs.db',
                },
                never_show = { '.DS_Store' },
            },
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            follow_current_file = {
                enabled = true,
            },
            hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
            -- use_libuv_file_watcher = false,
        },
    },
}

function M.config(_, opts)
    -- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    require('neo-tree').setup(opts)
end

return M
