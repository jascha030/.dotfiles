local uis = vim.api.nvim_list_uis()
local has_uis = #uis > 0

---@type table<string, string>
local FT_TO_LANG_ALIASES = {
    zsh = 'bash',
    dotenv = 'bash',
}

---@type string[]
local HIGHLIGHTING_DISABLED = {
    'zsh',
}

---@type string[]
local HIGHLIGHTING_ADD_VIM_REGEX = {
    'zsh',
}

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
            'nvim-treesitter/playground',
            cmd = 'TSPlaygroundToggle',
        },
        {
            'bleksak/treesitter-neon',
            ft = 'neon',
        },
        {
            'MTDL9/vim-log-highlighting',
            ft = 'log',
        },
    },
    opts = {
        auto_install = has_uis,
        sync_install = true,
        ensure_installed = {
            'bash',
            -- 'comment',
            'commonlisp',
            'css',
            'gitattributes',
            'git_config',
            'gitignore',
            'gitcommit',
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
            'toml',
            'typescript',
            'vim',
            'vimdoc',
            'yaml',
            'blade',
        },
        playground = { enable = true },
        query_linter = {
            enable = true,
            use_virtual_text = true,
        },
        indent = { enable = true },
        highlight = {
            enable = true,
            disable = function(lang, bufnr)
                return (
                    require('jascha030.utils.buffer').is_huge({ bufnr = bufnr })
                    or vim.tbl_contains(HIGHLIGHTING_DISABLED, lang)
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
    },
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

    -- Old way of registering parsers to langs
    --
    --
    -- ```lua
    --  local ft_to_lang = parsers.ft_to_lang
    --  parsers.ft_to_lang = function(ft) return ft_to_lang(ft) end
    -- ``

    -- Newer way of registering parsers to langs
    for ft, parser in pairs(FT_TO_LANG_ALIASES) do
        vim.treesitter.language.register(parser, ft)
    end
end

return M
