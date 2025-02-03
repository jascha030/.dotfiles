---@diagnostic disable: missing-fields

local NOTIFICATION_FILTERS = {
    '[Neo-tree INFO]',
    'Neo-tree INFO',
}

---@type LazyPluginSpec
local M = {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
}

function M.opts()
    ---@type snacks.Config
    local opts = {
        styles = {
            minimal = {
                relative = 'editor',
                border = 'solid',
            },
        },
        bigfile = { enabled = true },
        notifier = {
            enabled = false,
            -- style = 'minimal',
        },
        quickfile = { enabled = true },
        words = { enabled = true },
        input = { enabled = true },
        indent = { enabled = true },
        statuscolumn = { enabled = true },
        dim = { enabled = true },
    }

    ---@type snacks.dashboard.Config
    local dashboard_config = {
        enabled = true,
        preset = {
            keys = {
                {
                    pane = 1,
                    { title = 'Actions', padding = 1 },
                    {
                        icon = ' ',
                        key = 'n',
                        desc = 'New File',
                        action = ':ene | startinsert',
                    },
                    {
                        icon = ' ',
                        key = 'ff',
                        desc = 'Find File',
                        action = ":lua Snacks.dashboard.pick('files')",
                    },
                    {
                        icon = ' ',
                        key = 'fg',
                        desc = 'Find Text',
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                        padding = 1,
                    },
                },
                {
                    pane = 2,
                    { title = 'Utils', padding = 1 },
                    {
                        icon = '󰒲 ',
                        key = 'L',
                        desc = 'Lazy',
                        action = ':Lazy',
                        enabled = package.loaded.lazy ~= nil,
                    },
                    {
                        icon = ' ',
                        key = 'M',
                        desc = 'Mason',
                        action = ':Mason',
                    },
                    -- { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
                    {
                        icon = ' ',
                        key = 'q',
                        desc = 'Quit',
                        action = ':q',
                        padding = 1,
                    },
                },
            },
        },
        sections = {
            {
                section = 'startup',
                pane = 1,
                padding = 1,
            },
            {
                title = '',
                pane = 2,
                padding = 1,
            },
            -- { section = 'terminal', pane = 2, padding = 1, cmd = 'echo -n ${TERM}', hl = 'header' },
            { section = 'keys', pane_gap = 4 },
            {
                pane = 1,
                pane_gap = 4,
                { title = 'MRU ', file = vim.fn.fnamemodify('.', ':~'), padding = 1 },
                { section = 'recent_files', cwd = true, limit = 8, padding = 1 },
            },
            {
                pane = 2,
                pane_gap = 4,
                { title = 'MRU', padding = 1 },
                { section = 'recent_files', limit = 8, padding = 1 },
            },
        },
    }

    opts.dashboard = dashboard_config

    return opts
end

function M.keys()
    return {
        {
            '<leader>un',
            function()
                Snacks.notifier.hide()
            end,
            desc = 'Dismiss All Notifications',
        },
        {
            '<leader>bd',
            function()
                Snacks.bufdelete()
            end,
            desc = 'Delete Buffer',
        },
        {
            '<leader>lg',
            function()
                Snacks.lazygit()
            end,
            desc = 'Lazygit',
        },
        {
            '<leader>gb',
            function()
                Snacks.git.blame_line()
            end,
            desc = 'Git Blame Line',
        },
        {
            '<leader>gB',
            function()
                Snacks.gitbrowse()
            end,
            desc = 'Git Browse',
        },
        {
            '<leader>gf',
            function()
                Snacks.lazygit.log_file()
            end,
            desc = 'Lazygit Current File History',
        },
        {
            '<leader>gl',
            function()
                Snacks.lazygit.log()
            end,
            desc = 'Lazygit Log (cwd)',
        },
        {
            '<leader>cR',
            function()
                Snacks.rename.rename_file()
            end,
            desc = 'Rename File',
        },
        {
            '<leader>tf',
            function()
                Snacks.terminal('/bin/zsh --login', {
                    win = {
                        position = 'float',
                        border = BORDER,
                    },
                })
            end,
            desc = 'Toggle Terminal (Float)',
        },
        {
            '<leader>tb',
            function()
                Snacks.terminal('/bin/zsh --login', {
                    win = { position = 'bottom' },
                })
            end,
            desc = 'Toggle terminal (Bottom)',
        },
        {
            '<c-_>',
            function()
                Snacks.terminal()
            end,
            desc = 'which_key_ignore',
        },
        {
            ']]',
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = 'Next Reference',
            mode = { 'n', 't' },
        },
        {
            '[[',
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = 'Prev Reference',
            mode = { 'n', 't' },
        },
        {
            '<leader>N',
            desc = 'Neovim News',
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
                    width = 0.6,
                    height = 0.6,
                    border = 'rounded',
                    wo = { spell = false, wrap = false, signcolumn = 'yes', statuscolumn = ' ', conceallevel = 3 },
                })
            end,
        },
        {
            '<leader><leader>D',
            function()
                Snacks.dashboard()
            end,
            mode = 'n',
            desc = 'Open dashboard (snacks)',
        },
    }
end

function M.config(_, opts)
    local vim_notify = vim.notify
    require('snacks').setup(opts)

    local function _notify_filter(msg)
        for i = 1, #NOTIFICATION_FILTERS do
            -- stylua: ignore
            if string.find(msg, NOTIFICATION_FILTERS[i]) then return true end
        end

        return false
    end

    -- Custom vim.notify override
    ---@param msg string
    ---@param lvl number
    ---@param o table
    ---@see vim.notify
    local function _custom_notify(msg, lvl, o)
        return (lvl == vim.log.levels.INFO or _notify_filter(msg)) and vim_notify(msg, lvl, o)
            or Snacks.notifier.notify(msg, lvl, o)
    end

    vim.notify = _custom_notify
end

function M.init()
    vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
            -- Setup some globals for debugging (lazy-loaded)
            ---@diagnostic disable-next-line: duplicate-set-field
            _G.dd = function(...)
                Snacks.debug.inspect(...)
            end

            ---@diagnostic disable-next-line: duplicate-set-field
            _G.bt = function()
                Snacks.debug.backtrace()
            end

            vim.print = _G.dd -- Override print to use snacks for `:=` command
            -- Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
            -- Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
            Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
            Snacks.toggle.diagnostics():map('<leader>ud')
            Snacks.toggle.line_number():map('<leader>ul')
            Snacks.toggle
                .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                :map('<leader>uc')
            Snacks.toggle.treesitter():map('<leader>uT')
            Snacks.toggle.inlay_hints():map('<leader>uh')

            ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
            local progress = vim.defaulttable()
            vim.api.nvim_create_autocmd('LspProgress', {
                ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
                    if not client or type(value) ~= 'table' then
                        return
                    end
                    local p = progress[client.id]

                    for i = 1, #p + 1 do
                        if i == #p + 1 or p[i].token == ev.data.params.token then
                            p[i] = {
                                token = ev.data.params.token,
                                msg = ('[%3d%%] %s%s'):format(
                                    value.kind == 'end' and 100 or value.percentage or 100,
                                    value.title or '',
                                    value.message and (' **%s**'):format(value.message) or ''
                                ),
                                done = value.kind == 'end',
                            }
                            break
                        end
                    end

                    local msg = {} ---@type string[]
                    progress[client.id] = vim.tbl_filter(function(v)
                        return table.insert(msg, v.msg) or not v.done
                    end, p)

                    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
                    Snacks.notifier.notify(table.concat(msg, '\n'), 'info', {
                        id = 'lsp_progress',
                        title = client.name,
                        opts = function(notif)
                            notif.icon = #progress[client.id] == 0 and ' '
                                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                        end,
                        style = 'minimal',
                        top_down = false,
                        history = false,
                    })
                end,
            })
        end,
    })
end

-- vim.api.nvim_create_autocmd('LspProgress', {
--     ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
--     callback = function(ev)
--         local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
--         Snacks.notifier.notify(vim.lsp.status(), 'info', {
--             id = 'lsp_progress',
--             title = 'LSP Progress',
--             opts = function(notif)
--                 notif.icon = ev.data.params.value.kind == 'end' and ' '
--                     or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
--             end,
--         })
--     end,
-- })

return M
