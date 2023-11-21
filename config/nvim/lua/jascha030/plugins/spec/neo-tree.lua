local M = {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
    },
    opts = {
        source_selector = {
            winbar = true,
            statusline = false,
        },
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = {
            'terminal',
            'trouble',
        },
        window = {
            position = 'right',
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                always_hide = { '.DS_Store' },
            },
            follow_current_file = {
                enabled = false,
                leave_dirs_open = false,
            },
        },
    },
}

function M.config(_, opts)
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require('neo-tree').setup(opts)
end

return M
