---@type LazyPluginSpec[]
local M = {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'xzbdmw/colorful-menu.nvim',
            'giuxtaposition/blink-cmp-copilot',
        },
        build = function(plugin)
            local ret = vim.system({ 'cargo', 'build', '--release' }, { cwd = plugin.dir }):wait()

            vim.notify(ret.code == 0 and '[blink.cmp] build success!' or '[blink.cmp] build failed!')
        end,
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },
                ['<CR>'] = { 'select_and_accept', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
                ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            completion = {
                accept = { auto_brackets = { enable = true } },
                menu = {
                    border = BORDER,
                    draw = {
                        align_to = 'label',
                        padding = 1,
                        gap = 4,
                        columns = {
                            { 'label', 'label_description', gap = 1 },
                            { 'kind_icon', 'kind', gap = 1 },
                        },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require('colorful-menu').blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require('colorful-menu').blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    treesitter_highlighting = true,
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
                ghost_text = { enabled = true },
            },
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
                providers = {
                    lazydev = {
                        name = 'lazydev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                    crates = {
                        name = 'crates',
                        module = 'blink.compat.source',
                        fallbacks = { 'lsp' },
                    },
                    copilot = {
                        name = 'copilot',
                        module = 'blink-cmp-copilot',
                        score_offset = 50,
                        async = true,
                        transform_items = function(_, items)
                            local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = 'Copilot'
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                            end
                            return items
                        end,
                    },
                },
            },
        },
        opts_extend = {
            'sources.default',
        },
        appearance = {
            use_nvim_cmp_as_default = false,
            kind_icons = Jascha030.icons.get_icons().cmp_icons,
        },
    },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        build = '<cmd>Copilot auth<cr>',
        event = { 'InsertEnter' },
        keys = {
            {
                '<leader>uC',
                function()
                    if require('copilot.client').is_disabled() then
                        require('copilot.command').enable()
                    else
                        require('copilot.command').disable()
                    end
                end,
            },
        },
        opts = {
            enabled = true,
            should_attach = function(_, bufname)
                if string.match(bufname, 'env') then
                    return false
                end

                return true
            end,
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
        },
    },
    {
        'saghen/blink.compat',
        version = false,
        opts = {
            impersonate_nvim_cmp = true,
        },
    },
    {
        'L3MON4D3/LuaSnip',
        config = function(_, _)
            require('luasnip/loaders/from_vscode').lazy_load()
        end,
        build = 'make install_jsregexp',
    },
}

return M

