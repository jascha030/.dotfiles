---@class CmpPluginSpec: LazyPluginSpec
local M = {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lua',
        'JMarkin/cmp-diag-codes',
        'ray-x/cmp-treesitter',
        'saadparwaiz1/cmp_luasnip',
        'ncm2/ncm2',
        'onsails/Lspkind-nvim',
        {
            'L3MON4D3/LuaSnip',
            config = function(_, _)
                require('luasnip/loaders/from_vscode').lazy_load()
            end,
            build = 'make install_jsregexp',
        },
    },
    opts = {
        sources = {
            -- { name = 'lazydev', group_index = 0, priority_weight = 130 },
            { name = 'nvim_lsp_signature_help', priority_weight = 120 },
            { name = 'path', priority_weight = 110 },
            { name = 'nvim_lsp', priority_weight = 100 },
            { name = 'nvim_lua', priority_weight = 90 },
            { name = 'treesitter', priority_weight = 80 },
            { name = 'luasnip', priority_weight = 60 },
            { name = 'buffer', max_item_count = 3, priority_weight = 60 },
            { name = 'diag-codes', priority_weight = 50, option = { in_comment = true } },
        },
    },
}

function M.check_backspace()
    local col = vim.fn.col('.') - 1

    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

function M.config(_, opts)
    local luasnip = require('luasnip')
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    local mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(
            cmp.mapping.complete({
                reason = cmp.ContextReason.Manual,
                config = { sources = { { name = 'nvim_lsp' } } },
            }),
            { 'i', 'c' }
        ),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif M.check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-o>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert(mapping),
        formatting = {
            expandable_indicator = true,
            fields = { 'kind', 'abbr', 'menu' },
            format = lspkind.cmp_format({
                with_text = false,
                menu = {
                    -- lazydev = '  [lazy]',
                    nvim_lsp_signature_help = '  [lsp]',
                    buffer = '  [buff]',
                    copilot = '  [cplt]',
                    nvim_lsp = '  [lsp]',
                    luasnip = '  [snip]',
                    path = ' 󱝵 [path]',
                },
            }),
        },
        sources = cmp.config.sources(opts.sources),
        window = {
            documentation = cmp.config.window.bordered(),
            completion = cmp.config.window.bordered(),
        },
        experimental = {
            ghost_text = false,
            native_menu = false,
        },
    })

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })
end

return M
