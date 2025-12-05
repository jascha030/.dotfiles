---IntelliJ-like smart backspace
---
---@param cmp blink.cmp.API
---@return boolean | nil
local function smart_backspace(cmp)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    if row == 1 and col == 0 then
        return
    end

    if cmp.is_visible() then
        cmp.hide()
    end

    local ts = require('nvim-treesitter.indent')
    local ok, indent = pcall(ts.get_indent, row)
    if not ok then
        indent = 0
    end

    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
    if vim.fn.strcharpart(line, indent - 1, col - indent + 1):gsub('%s+', '') ~= '' then
        return
    end

    if indent > 0 and col > indent then
        local new_line = vim.fn.strcharpart(line, 0, indent) .. vim.fn.strcharpart(line, col)
        vim.schedule(function()
            vim.api.nvim_buf_set_lines(0, row - 1, row, true, {
                new_line,
            })
            vim.api.nvim_win_set_cursor(0, { row, math.min(indent or 0, vim.fn.strcharlen(new_line)) })
        end)
        return true
    elseif row > 1 and (indent > 0 and col + 1 > indent) then
        local prev_line = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, true)[1]
        if vim.trim(prev_line) == '' then
            local prev_indent = ts.get_indent(row - 1) or 0
            local new_line = vim.fn.strcharpart(line, 0, prev_indent) .. vim.fn.strcharpart(line, col)
            vim.schedule(function()
                vim.api.nvim_buf_set_lines(0, row - 2, row, true, {
                    new_line,
                })

                vim.api.nvim_win_set_cursor(0, {
                    row - 1,
                    math.max(0, math.min(prev_indent, vim.fn.strcharlen(new_line))),
                })
            end)
            return true
        else
            local len = vim.fn.strcharlen(prev_line)
            local new_line = prev_line .. vim.fn.strcharpart(line, col)
            vim.schedule(function()
                vim.api.nvim_buf_set_lines(0, row - 2, row, true, {
                    new_line,
                })
                vim.api.nvim_win_set_cursor(0, { row - 1, math.max(0, len) })
            end)
            return true
        end
    end
end

---@type LazyPluginSpec[]
local M = {
    {
        'saghen/blink.cmp',
        dependencies = {
            'saghen/blink.compat',
            'xzbdmw/colorful-menu.nvim',
            'rafamadriz/friendly-snippets',
            'copilotlsp-nvim/copilot-lsp',
            'fang2hou/blink-copilot',
            'onsails/lspkind-nvim',
        },
        build = function(plugin)
            local ret = vim.system({ 'cargo', 'build', '--release' }, { cwd = plugin.dir }):wait()

            vim.notify(ret.code == 0 and '[blink.cmp] build success!' or '[blink.cmp] build failed!')
        end,
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ['<M-Tab>'] = {
                    function(cmp)
                        if vim.b[vim.api.nvim_get_current_buf()].nes_state then
                            cmp.hide()
                            return require('copilot-lsp.nes').apply_pending_nes()
                        end
                    end,
                    'fallback',
                },
                ['<BS>'] = {
                    smart_backspace,
                    'fallback',
                },
                ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<CR>'] = { 'select_and_accept', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
                ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'show', 'fallback' },
                ['<C-n>'] = { 'select_next', 'show', 'fallback' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            },
            cmdline = {
                enabled = true,
                completion = { menu = { auto_show = true } },
                keymap = {
                    preset = 'none',
                    ['<Tab>'] = { 'select_next', 'fallback' },
                    ['<S-Tab>'] = { 'select_prev', 'fallback' },
                    ['<Up>'] = { 'select_prev', 'fallback' },
                    ['<Down>'] = { 'select_next', 'fallback' },
                },
            },
            completion = {
                accept = { auto_brackets = { enabled = true } },
                menu = {
                    border = BORDER,
                    draw = {
                        -- treesitter = { 'lsp', 'copilot' },
                        padding = 1,
                        gap = 1,
                        columns = {
                            { 'kind_icon' },
                            { 'label', gap = 1 },
                            { 'kind' },
                        },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                                        local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require('lspkind').symbolic(ctx.kind, {
                                            mode = 'symbol',
                                        })
                                    end

                                    return icon .. ctx.icon_gap
                                end,

                                -- Optionally, use the highlight groups from nvim-web-devicons
                                -- You can also add the same function for `kind.highlight` if you want to
                                -- keep the highlight groups in sync with the icons.
                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                                        local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            },

                            kind = {
                                ellipsis = false,
                                text = function(ctx)
                                    return ctx.kind .. ' '
                                end,
                                highlight = function(ctx)
                                    return 'BlinkCmpKind' .. ctx.kind
                                end,
                            },
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx)
                                    return require('colorful-menu').blink_components_text(ctx)
                                end,
                                -- text = function(ctx)
                                --     return ctx.label .. (ctx.label_detail or '')
                                -- end,
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
                -- list = {
                --     selection = {
                --         preselect = false,
                --         auto_insert = false,
                --     },
                -- },
                ghost_text = { enabled = true },
            },
            sources = {
                default = { 'buffer', 'snippets', 'path', 'lsp', 'copilot' },
                per_filetype = {
                    toml = { 'buffer', 'snippets', 'copilot', 'path', 'lsp', 'crates' },
                    lua = { 'buffer', 'snippets', 'path', 'lsp', 'lazydev', 'copilot' },
                },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 2,
                        fallbacks = { 'lsp' },
                    },
                    crates = {
                        name = 'Crates',
                        module = 'blink.compat.source',
                        score_offset = 2,
                        -- async = true,
                    },
                    copilot = {
                        name = 'Copilot',
                        module = 'blink-copilot',
                        enabled = function()
                            local flag = vim.g.blink_cmp_copilot_enabled --[[@as boolean?]]

                            return flag == nil or flag
                        end,
                        score_offset = 100,
                        deduplicate = { enabled = true },
                        async = true,
                        max_items = 2,
                        opts = { max_completions = 2 },
                    },
                },
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            -- nerd_font_variant = 'normal',
            kind_icons = Jascha030.icons.get_icons().cmp_icons,
        },
    },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        -- build = '<cmd>Copilot auth<cr>',
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
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        build = 'make install_jsregexp',
        -- config = function(_, _)
        --     require('luasnip/loaders/from_vscode').lazy_load()
        -- end,
        -- build = 'make install_jsregexp',
    },
}

return M
