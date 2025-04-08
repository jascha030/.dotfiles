local function blink_build(plugin)
    local ret = vim.system({ 'cargo', 'build', '--release' }, { cwd = plugin.dir }):wait()
    vim.notify(ret.code == 0 and '[blink.cmp] build success!' or '[blink.cmp] build failed!')
end

---@type LazyPluginSpec[]
local M = {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'xzbdmw/colorful-menu.nvim',
        },
        build = blink_build,
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            appearance = {
                use_nvim_cmp_as_default = true,
                -- use_nvim_cmp_as_default = false,
            },
            keymap = {
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
                ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            completion = {
                menu = {
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { 'kind_icon' }, { 'label', gap = 1 } },
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
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                    crates = {
                        name = 'crates',
                        module = 'blink.compat.source',
                        fallbacks = { 'lsp' },
                    },
                },
            },
        },
        opts_extend = {
            'sources.default',
        },
    },
    {
        'saghen/blink.compat',
        version = false,
        opts = { impersonate_nvim_cmp = true },
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
