SERVERS = {
    'angularls',
    'bashls',
    'intelephense',
    'jsonls',
    'lua_ls',
    'marksman',
    'phpactor',
    'rust_analyzer',
    -- 'sourcekit',
    'tailwindcss',
}

---@type LazyPluginSpec[]|string[]
return {
    'williamboman/mason-lspconfig.nvim',
    'ray-x/lsp_signature.nvim',
    'yioneko/nvim-vtsls',
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        dependencies = { 'Bilal2453/luvit-meta' },
        ---@type lazydev.Config
        opts = {
            library = {
                'annotations',
                'luvit-meta/library',
                vim.env.VIMRUNTIME,
                'lazy.nvim',
                'lazydev.nvim',
                'nvim-lspconfig',
                'nvim-treesitter',
                unpack(vim.api.nvim_get_runtime_file('lua/vim', true)),
            },
            integrations = {
                cmp = true,
                lsp = true,
                lspconfig = true,
            },
        },
    },
    -- {
    --     'saghen/blink.compat',
    --     version = '*',
    --     lazy = true,
    --     opts = { impersonate_nvim_cmp = true },
    -- },
    -- {
    --     -- optional blink completion source for require statements and module annotations
    --     'saghen/blink.cmp',
    --     build = function(plugin)
    --         local ret = vim.system({ 'cargo', 'build', '--release' }, { cwd = plugin.dir }):wait()
    --         vim.notify(ret.code == 0 and '[blink.cmp] build success!' or '[blink.cmp] build failed!')
    --     end,
    --     event = { 'InsertEnter' },
    --     dependencies = {
    --         'hrsh7th/nvim-cmp',
    --         'neovim/nvim-lspconfig',
    --         'hrsh7th/cmp-nvim-lsp',
    --         'hrsh7th/cmp-nvim-lsp-document-symbol',
    --         'hrsh7th/cmp-nvim-lsp-signature-help',
    --         'hrsh7th/cmp-path',
    --         'hrsh7th/cmp-buffer',
    --         'hrsh7th/cmp-vsnip',
    --         'hrsh7th/cmp-cmdline',
    --         'hrsh7th/cmp-nvim-lua',
    --         'JMarkin/cmp-diag-codes',
    --         'ray-x/cmp-treesitter',
    --         'saadparwaiz1/cmp_luasnip',
    --         'ncm2/ncm2',
    --         'onsails/Lspkind-nvim',
    --         {
    --             'L3MON4D3/LuaSnip',
    --             config = function(_, _)
    --                 require('luasnip/loaders/from_vscode').lazy_load()
    --             end,
    --             build = 'make install_jsregexp',
    --         },
    --     },
    --     opts = {
    --         appearance = { use_nvim_cmp_as_default = true },
    --         keymap = {
    --             ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    --             ['<C-e>'] = { 'hide' },
    --             ['<CR>'] = { 'accept', 'fallback' },
    --             ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    --             ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    --             ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    --             ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    --         },
    --         completion = {
    --             list = {
    --                 selection = {
    --                     preselect = false,
    --                     auto_insert = false,
    --                 },
    --             },
    --             documentation = {
    --                 auto_show = true,
    --                 auto_show_delay_ms = 50,
    --             },
    --             ghost_text = { enabled = true },
    --         },
    --         sources = {
    --             default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    --             providers = {
    --                 lazydev = {
    --                     name = 'LazyDev',
    --                     module = 'lazydev.integrations.blink',
    --                     score_offset = 100,
    --                 },
    --                 crates = {
    --                     name = 'crates',
    --                     module = 'blink.compat.source',
    --                     fallbacks = { 'lsp' },
    --                 },
    --             },
    --         },
    --     },
    -- },
    {
        'nvimdev/lspsaga.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            ui = { border = BORDER },
            lightbulb = { enable = false },
        },
    },
    {
        'simrat39/rust-tools.nvim',
        dependencies = { 'rust-lang/rust.vim' },
        ft = 'rs',
        lazy = true,
    },
    {
        'gbprod/phpactor.nvim',
        ft = { 'php' },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        },
        build = function()
            require('phpactor.handler.update')()
        end,
        config = true,
    },
    {
        'j-hui/fidget.nvim',
        name = 'fidget',
        event = { 'LspAttach' },
        opts = {
            progress = {
                ignore = {
                    -- 'phpactor',
                },
            },
            notification = {
                window = {
                    normal_hl = 'Comment', -- Base highlight group in the notification window
                    winblend = 0, -- Background color opacity in the notification window
                    border = 'none', -- Border around the notification window
                    zindex = 45, -- Stacking priority of the notification window
                    max_width = 0, -- Maximum width of the notification window
                    max_height = 0, -- Maximum height of the notification window
                    x_padding = 1, -- Padding from right edge of window boundary
                    y_padding = 0, -- Padding from bottom edge of window boundary
                    align = 'bottom', -- How to align the notification window
                    -- relative = 'editor', -- What the notification window position is relative to
                    relative = 'win', -- What the notification window position is relative to
                },
            },
        },
    },
    {
        'smjonas/inc-rename.nvim',
        cmd = { 'IncRename' },
        keys = {
            {
                '<leader>rn',
                function()
                    vim.api.nvim_feedkeys(':IncRename ' .. vim.fn.expand('<cword>'), 'n', true)
                end,
                desc = 'rename',
            },
        },
        opts = {
            show_message = false,
            post_hook = function(opts)
                local nrenames, nfiles = unpack(vim.iter(opts)
                    :map(function(_, renames)
                        return vim.tbl_count(renames)
                    end)
                    :fold({ 0, 0 }, function(acc, val)
                        acc[1] = acc[1] + val
                        acc[2] = acc[2] + 1
                        return acc
                    end))

                vim.notify(
                    string.format('%d instance%s in %d files', nrenames, nrenames == 1 and '' or 's', nfiles),
                    vim.log.levels.INFO,
                    { title = 'RENAMED' }
                )
            end,
        },
    },
    {
        'williamboman/mason.nvim',
        cmd = { 'Mason' },
        keys = {
            { '<leader><leader>m', '<cmd>Mason<cr>', desc = 'Mason' },
        },
        opts = function(_, opts)
            opts.ensure_installed = {
                'angular-language-server',
                'bash-language-server',
                'beautysh',
                'black',
                'blade-formatter',
                'css-lsp',
                'eslint_d',
                'flake8',
                'html-lsp',
                'intelephense',
                'isort',
                'json-lsp',
                'lua-language-server',
                'luacheck',
                'markdownlint',
                'marksman',
                'phpactor',
                'phpstan',
                'psalm',
                'rust-analyzer',
                'shellcheck',
                'shfmt',
                'stylelint',
                'stylelint-lsp',
                'stylua',
                'svelte-language-server',
                'tailwindcss-language-server',
                'taplo',
                'typescript-language-server',
                'yaml-language-server',
                'yamlfix',
                'yamlfmt',
            }

            opts.ui = BORDERS

            return opts
        end,
        lazy = true,
        config = function(_, opts)
            require('mason').setup(opts)
            local registry = require('mason-registry')

            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = registry.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end

            if registry.refresh then
                registry.refresh(ensure_installed)
            else
                ensure_installed()
            end

            for _, tool in ipairs(opts.ensure_installed) do
                local p = registry.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        priority = 70,
        lazy = false,
        version = '*',
        opts = function(_, _)
            ---@class PluginLspOpt
            return {
                ---@type lspconfig.Config
                ensure_installed = SERVERS,
                servers = { sourcekit = require('jascha030.lsp.servers.sourcekit') },
                ---@type vim.diagnostic.Opts
                diagnostics = {
                    severity_sort = true,
                    signs = { text = require('jascha030.core.icons').get_icons().diagnostics },
                    underline = true,
                    update_in_insert = false,
                    virtual_text = { spacing = 4, source = 'if_many', prefix = '●' },
                },
                inlay_hints = { enabled = vim.fn.has('nvim-0.10') == 1 },
            }
        end,
        config = function(_, opts)
            require('jascha030.lsp').setup(opts)
        end,
    },
}
