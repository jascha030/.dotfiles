---@type LazyPluginSpec[]|string[]
return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim',
            'folke/lazydev.nvim',
        },
        opts = function(_, _)
            return {
                ensure_installed = {
                    'angularls',
                    'bashls',
                    'intelephense',
                    'jsonls',
                    'lua_ls',
                    'marksman',
                    'phpactor',
                    'rust_analyzer',
                    'tailwindcss',
                },
                ---@todo: maybe just do this per client instead of capability.
                disabled_capabilities = {
                    ['documentFormattingProvider'] = {
                        'intelephense',
                        'jsonls',
                        'lua_ls',
                    },
                    ['documentRangeFormattingProvider'] = {
                        'intelephense',
                        'jsonls',
                        'lua_ls',
                    },
                    ['hoverProvider'] = {
                        'phpactor',
                    },
                    ['referencesProvider'] = {
                        'phpactor',
                    },
                },
            }
        end,
        config = function(_, opts)
            opts = opts or {}
            local lsp = require('jascha030.lsp')

            vim.diagnostic.config({
                severity_sort = true,
                signs = { text = require('jascha030.core.icons').get_icons().diagnostics },
                underline = true,
                update_in_insert = false,
                virtual_lines = {
                    current_line = true,
                },
            })

            lsp.lsp_attach(function(client, buffer)
                for capability, clients in pairs(opts.disabled_capabilities) do
                    if vim.tbl_contains(clients, client.name) then
                        client.server_capabilities[capability] = false
                    end
                end

                if client.server_capabilities.completionProvider then
                    vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'
                end

                if client.server_capabilities.definitionProvider then
                    vim.bo[buffer].tagfunc = 'v:lua.vim.lsp.tagfunc'
                end

                if client.name == 'yamlls' then
                    client.server_capabilities.documentFormattingProvider = true
                end
            end)

            lsp.lsp_attach(lsp.keymaps.on_attach)
            lsp.inlay_hints()

            local disabled_clients = {
                'psalm',
                'ts_ls',
                'ast_grep',
            }

            local function init()
                vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
                    :map(function(server_config_path)
                        return vim.fs.basename(server_config_path):match('^(.*)%.lua$')
                    end)
                    :each(vim.schedule_wrap(function(server_name)
                        -- local config = lsp.config.get(server_name)
                        -- if config then
                        --     vim.lsp.config(server_name, config)
                        -- end
                        if not vim.tbl_contains(disabled_clients, server_name) then
                            vim.lsp.enable(server_name)
                        end
                    end))
            end

            if vim.g.did_very_lazy then
                vim.schedule(init)
            else
                vim.api.nvim_create_autocmd('User', {
                    pattern = 'VeryLazy',
                    once = true,
                    callback = vim.schedule_wrap(init),
                })
            end

            require('lspconfig.configs').vtsls = require('vtsls').lspconfig
            require('mason-lspconfig').setup({
                automatic_enable = {
                    exclude = disabled_clients,
                },
                automatic_installation = true,
                ensure_installed = opts.ensure_installed,
            })
        end,
    },

    { 'ray-x/lsp_signature.nvim' },
    { 'yioneko/nvim-vtsls' },
    -- Otter.nvim provides lsp features for code embedded in other documents (markdown)
    {
        'jmbuhr/otter.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        dependencies = { 'Bilal2453/luvit-meta' },
        ---@type lazydev.Config
        ---@diagnostic disable-next-line: missing-fields
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
            progress = { ignore = {} },
            notification = {
                window = {
                    normal_hl = 'Comment', -- Base highlight group in the notification window
                    winblend = 0, -- Background color opacity in the notification window
                    border = BORDER, -- Border around the notification window
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
        'mason-org/mason.nvim',
        cmd = { 'Mason' },
        keys = { { '<leader><leader>m', '<cmd>Mason<cr>', desc = 'Mason' } },
        opts = function(_, opts)
            opts.ensure_installed = {
                'angular-language-server',
                'bash-language-server',
                'beautysh',
                'black',
                'blade-formatter',
                'css-lsp',
                'eslint_d',
                'fennel-ls',
                'fennel-language-server',
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
            opts.ui = { border = BORDER }

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
        end,
    },
}
