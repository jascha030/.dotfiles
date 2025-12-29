---@diagnostic disable: missing-fields, undefined-field

-- Patterns to filter out notifications, these will use the normal vim.notify.
local NOTIFICATION_FILTERS = {
    'Neo-tree INFO',
    'Config Change Detected.',
}

---@type LazyPluginSpec
local M = {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
}

function M.opts()
    ---@module 'snacks'
    ---@type snacks.Config
    local opts = {
        styles = { minimal = { border = 'solid' } },
        bigfile = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = true },
        words = { enabled = true },
        input = { enabled = true },
        image = { enabled = true },
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
                        key = 'f',
                        desc = 'Find File',
                        action = ":lua Snacks.dashboard.pick('files')",
                    },
                    {
                        icon = ' ',
                        key = 'g',
                        desc = 'Find Text',
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                        padding = 1,
                    },
                },
                {
                    pane = 2,
                    {
                        title = 'Utils',
                        padding = 1,
                    },
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
        formats = {
            key = function(item)
                return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
            end,
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
            {
                section = 'keys',
                pane_gap = 4,
            },
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

-- stylua: ignore 
function M.keys()
    return {
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
        { "<leader>fe", function() Snacks.explorer() end, desc = "File Explorer" },

        { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications', },
        { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer', },
        { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File', },
        { '<leader>tf', function() Snacks.terminal('/bin/zsh --login', { win = { position = 'float', border = BORDER } }) end, desc = 'Toggle Terminal (Float)', },
        { '<leader>tb', function() Snacks.terminal('/bin/zsh --login', { win = { position = 'bottom' } }) end, desc = 'Toggle terminal (Bottom)', },

        { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' }, },
        { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' }, },

        {
            '<leader><leader>N',
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

        -- GIT
        { '<leader>lg', function() Snacks.lazygit() end, desc = 'Lazygit', },
        { '<leader>gb', function() Snacks.git.blame_line() end, desc = 'Git Blame Line', },
        { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', },
        { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
        { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Lazygit Log (cwd)', },
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },

        -- Find stuff
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { '<leader>ff', function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
        { '<leader>fm', function() Snacks.notifier.show_history() end, desc = "Message history" },

        { "<leader><leader>p", function() Snacks.picker.projects() end, desc = "Projects" },
        { "<C-p>", function() Snacks.picker.git_files() end, desc = "Find Git Files" },

        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        { "<leader>st", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

        -- LSP
        { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition', },
        { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration', },
        { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References', },
        { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation', },
        { 'gt', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition', },
        { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols', },
        { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols', },
        { "<leader><leader>L", function() Snacks.picker.lsp_config() end, desc = "LSP Configs" },
    }
end
-- stylua: ignore end

---@param _ any
---@param opts snacks.Config
function M.config(_, opts)
    local vim_notify = vim.notify
    require('snacks').setup(opts)

    -- MONKEY PATCH: Position notifications on the left
    local function patch_notifier_left()
        local notifier_module = require('snacks.notifier')

        -- Get the internal notifier class through the module's metatable or direct access
        local N = getmetatable(notifier_module).__index or notifier_module

        -- If that doesn't work, try accessing through the global Snacks object
        if not N or not N.layout then
            N = require('snacks').notifier
        end

        -- Still no luck? Try getting it through the notifier instance
        if not N or not N.layout then
            -- Access the notifier instance through the closure
            local original_notify = notifier_module.notify
            local info = debug.getinfo(original_notify, 'u')
            for i = 1, info.nups do
                local name, value = debug.getupvalue(original_notify, i)
                if name == 'notifier' and value and type(value) == 'table' and value.layout then
                    N = getmetatable(value).__index or value
                    break
                end
            end
        end

        if N and N.layout then
            -- Store the original layout function
            -- local original_layout = N.layout

            -- Override the layout function
            ---@diagnostic disable-next-line: inject-field
            N.layout = function(self)
                local layout = self:new_layout()
                local wins_updated = 0
                local wins_created = 0
                local update = {} ---@type snacks.win[]

                for _, notif in ipairs(assert(self.sorted)) do
                    if layout.free < (self.opts.height.min + 2) then -- not enough space
                        if notif.win then
                            notif.shown = nil
                            notif.win:hide()
                        end
                    else
                        local prev_layout = notif.layout
                            and { top = notif.layout.top, height = notif.layout.height, width = notif.layout.width }

                        if
                            not notif.win
                            or notif.dirty
                            or not notif.win:buf_valid()
                            or type(notif.opts) == 'function'
                        then
                            notif.dirty = true
                            self:render(notif)
                            notif.dirty = false
                            notif.layout = notif.win:size()
                            notif.layout.top = prev_layout and prev_layout.top
                            prev_layout = nil -- always re-render since opts might've changed
                        end

                        notif.layout.top = layout.find(notif.layout.height, notif.layout.top)

                        if notif.layout.top then
                            layout.mark(notif.layout.top, notif.layout.height, false)

                            if not vim.deep_equal(prev_layout, notif.layout) then
                                if notif.win:win_valid() then
                                    wins_updated = wins_updated + 1
                                else
                                    wins_created = wins_created + 1
                                end
                                update[#update + 1] = notif.win

                                -- HIERO MANBROER, IS BELANGRIJK, INSHALLAH.
                                --
                                notif.win.opts.row = (notif.layout.top - 1) + 3 -- die 3 is extra marginionio 4 statousjlijn
                                --
                                -- Original: notif.win.opts.col = vim.o.columns - notif.layout.width - self.opts.margin.right
                                -- Custom attempt 1: Position on LEFT instead of right | Which turned out to be F-ing stupid...*facepalm*
                                -- notif.win.opts.col = self.opts.margin.left or 1

                                notif.win.opts.col = math.floor((vim.o.columns - notif.layout.width) / 2)

                                -- Get timestamp
                                local uv = vim.uv or vim.loop
                                notif.shown = notif.shown
                                    or (function()
                                        if uv.clock_gettime then
                                            local ret = assert(uv.clock_gettime('realtime'))
                                            return ret.sec + ret.nsec / 1e9
                                        end
                                        local sec, usec = uv.gettimeofday()
                                        return sec + usec / 1e6
                                    end)()

                                notif.win:show()
                            end
                        elseif notif.win then
                            notif.shown = nil
                            notif.win:hide()
                        end
                    end
                end

                if #update > 0 and not self.in_search() then
                    if vim.api.nvim__redraw then
                        for _, win in ipairs(update) do
                            win:redraw()
                        end
                    else
                        vim.cmd.redraw()
                    end
                end
            end
        else
            vim.notify('Failed to patch snacks notifier - could not find layout function', vim.log.levels.WARN)
        end
    end

    -- Apply the patch
    patch_notifier_left()

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
        if lvl == vim.log.levels.INFO or _notify_filter(msg) then
            return vim_notify(msg, lvl, o)
        end

        return Snacks.notifier.notify(msg, lvl, o)
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
        end,
    })
end

return M
