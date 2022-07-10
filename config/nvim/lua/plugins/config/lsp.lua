local cmp_config = function()
    local cmp_status_ok, cmp = pcall(require, 'cmp')
    if not cmp_status_ok then
        return
    end

    local snip_status_ok, luasnip = pcall(require, 'luasnip')
    if not snip_status_ok then
        return
    end

    require('luasnip/loaders/from_vscode').lazy_load()

    local check_backspace = function()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
    end

    --   פּ ﯟ   some other good icons
    local kind_icons = {
        Text = '',
        Method = 'm',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = '',
        Interface = '',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
    }
    -- find more here: https://www.nerdfonts.com/cheat-sheet

    local mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
    }

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = mapping,
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
                vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    luasnip = '[Snippet]',
                    buffer = '[Buffer]',
                    path = '[Path]',
                })[entry.source.name]

                return vim_item
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
        }),
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        window = {
            documentation = cmp.config.window.bordered(),
            completion = cmp.config.window.bordered(),
        },
        experimental = {
            ghost_text = false,
            native_menu = false,
        },
    })
end

local function trouble()
    return {
        position = 'bottom', -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = 'workspace_diagnostics', -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = '', -- icon used for open folds
        fold_closed = '', -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            close = 'q', -- close the list
            cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
            refresh = 'r', -- manually refresh
            jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
            open_split = { '<c-x>' }, -- open buffer in new split
            open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
            open_tab = { '<c-t>' }, -- open buffer in new tab
            jump_close = { 'o' }, -- jump to the diagnostic and close the list
            toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = 'P', -- toggle auto_preview
            hover = 'K', -- opens a small popup with the full multiline message
            preview = 'p', -- preview the diagnostic location
            close_folds = { 'zM', 'zm' }, -- close all folds
            open_folds = { 'zR', 'zr' }, -- open all folds
            toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
            previous = 'k', -- preview item
            next = 'j', -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { 'lsp_definitions' }, -- for the given modes, automatically jump if there is only a single result
        signs = {
            -- icons / text used for a diagnostic
            error = '',
            warning = '',
            hint = '',
            information = '',
            other = '﫠',
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    }
end

return {
    cmp = cmp_config,
    trouble = trouble,
}
