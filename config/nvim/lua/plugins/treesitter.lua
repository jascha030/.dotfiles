local uis = vim.api.nvim_list_uis()
local has_uis = #uis > 0

---@type table<string, string>
local FT_TO_LANG_ALIASES = { dotenv = 'bash' }

---@type string[]
local HIGHLIGHTING_DISABLED = { 'zsh' }

---@type string[]
local HIGHLIGHTING_ADD_VIM_REGEX = { 'zsh' }

---@type LazyPluginSpec
--- Check Runtime files :echo nvim_get_runtime_file('parser', v:true)
local M = {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    cond = has_uis,
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            event = 'VeryLazy',
        },
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = true,
        },
        {
            'p00f/nvim-ts-rainbow',
            lazy = true,
        },
        {
            'theHamsta/nvim-treesitter-commonlisp',
            ft = 'query',
        },
        {
            'bleksak/treesitter-neon',
            ft = 'neon',
        },
        {
            'MTDL9/vim-log-highlighting',
            ft = 'log',
        },
        {
            'folke/ts-comments.nvim',
            opts = {},
            event = 'VeryLazy',
        },
    },
    opts = function()
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        local ts_config = {
            auto_install = has_uis,
            sync_install = true,
            ensure_installed = {
                'bash',
                'blade',
                'comment',
                'commonlisp',
                'css',
                'git_config',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'javascript',
                'json',
                'json5',
                'jsonc',
                'lua',
                'markdown',
                'markdown_inline',
                'ocaml',
                'ocaml_interface',
                'php',
                'phpdoc',
                'python',
                'query',
                'regex',
                'swift',
                'html',
                'xml',
                'scss',
                'toml',
                'typescript',
                'vim',
                'vimdoc',
                'yaml',
            },
            query_linter = {
                enable = true,
                use_virtual_text = true,
            },
            indent = { enable = true },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

                    return (
                        (ok and stats and stats.size > max_filesize) or vim.tbl_contains(HIGHLIGHTING_DISABLED, lang)
                    )
                end,
                use_languagetree = true,
                additional_vim_regex_highlighting = HIGHLIGHTING_ADD_VIM_REGEX,
            },
            rainbow = {
                enable = false,
                extended_mode = true,
                max_file_lines = 1000,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<cr>',
                    node_incremental = '<cr>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },
            textobjects = {
                ['aa'] = '@parameters.outer',
                ['ia'] = '@parameters.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner',
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner',
                },
            },
        }

        return ts_config
    end,
}

function M.config(_, opts)
    local parsers = require('nvim-treesitter.parsers')

    require('nvim-treesitter.configs').setup(opts)

    local parser_config = parsers.get_parser_configs()

    --- @module "jascha030.core.filetypes"
    require('jascha030.core.filetypes').setup()

    ---@diagnostic disable-next-line: inject-field
    parser_config.blade = {
        install_info = {
            url = 'https://github.com/EmranMR/tree-sitter-blade',
            files = { 'src/parser.c' },
            branch = 'main',
        },
        filetype = 'blade',
    }

    ---@diagnostic disable-next-line: inject-field
    parser_config.neon = {
        install_info = {
            url = vim.fn.expand('$HOME/.local/share/nvim/lazy/treesitter-neon'),
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
            files = { 'src/parser.c', 'src/scanner.c' },
        },
        filetype = 'neon',
    }

    for ft, parser in pairs(FT_TO_LANG_ALIASES) do
        vim.treesitter.language.register(parser, ft)
    end
end

return M
