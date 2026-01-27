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
                        padding = 1,
                        gap = 1,
                        columns = function(ctx)
                            return {
                                { 'kind_icon' },
                                { 'label', gap = 1 },
                                { 'kind' },
                            }
                        end,
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    -- Snacks.debug.inspect(ctx, 'kind_icon ctx')
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                                        local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require('lspkind').symbolic(ctx.kind)
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
            appearance = {
                -- use_nvim_cmp_as_default = true,
                -- nerd_font_variant = 'normal',
                ---@diagnostic disable-next-line: assign-type-mismatch
                kind_icons = Jascha030.icons.get_icons().cmp_icons,
            },
        },
        config = function(_, opts)
            local cmp = require('blink.cmp')

            --- Check if Noice popup cmdline is enabled.
            local function has_noice_popup_cmdline()
                local ok, config = pcall(require, 'noice.config')
                return ok
                    and (config.options.cmdline or {}).enabled ~= false
                    and ((config.options.views or {}).cmdline_popup or {}).backend ~= 'split'
            end

            if not has_noice_popup_cmdline() then
                cmp.setup(opts)
            else
                -- Override the cmdline_position function to align with Noice popup cmdline.
                opts.completion.menu.cmdline_position = function()
                    if vim.g.ui_cmdline_pos ~= nil then
                        local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed

                        -- If bottom cmdline instead of floating cmdline, move menu 1 up.
                        local vert = pos[1] + 1 == vim.o.lines and pos[1] - 1 or pos[1]

                        return { vert, pos[2] }
                    end

                    local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                    return { vim.o.lines - height, 0 }
                end

                cmp.setup(opts)

                ---Get win width for buffer number.
                ---
                ---@param buf_num number
                ---@return number|nil
                local function get_buffer_width(buf_num)
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        if vim.api.nvim_win_get_buf(win) == buf_num then
                            return vim.api.nvim_win_get_width(win)
                        end
                    end

                    return nil
                end

                local menu = require('blink.cmp.completion.windows.menu')
                local config = require('blink.cmp.config').completion.menu
                local original_update_position = menu.update_position

                --- Override the update_position method to render the menu with the same width as Noice popup cmdline.
                ---@diagnostic disable-next-line: duplicate-set-field
                menu.update_position = function()
                    -- Check the context mode for the current menu instance
                    local _cmdtype = vim.fn.getcmdtype()
                    if menu.context and menu.context.mode == 'cmdline' and (_cmdtype ~= '/' and _cmdtype ~= '?') then
                        local Cmdline = require('noice.ui.cmdline')
                        local width = get_buffer_width(Cmdline.position.buf)

                        if width ~= nil then
                            menu.win.config.min_width = width
                            menu.win.config.max_width = width
                        end
                    else
                        menu.win.config.min_width = config.min_width
                        ---@diagnostic disable-next-line: undefined-field
                        menu.win.config.max_width = config.max_width
                    end

                    original_update_position()
                end
            end
        end,
    },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
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
                desc = 'Toggle Copilot',
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
    },
}

return M
