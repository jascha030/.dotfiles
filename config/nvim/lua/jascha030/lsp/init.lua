---@class jascha030.lsp.Module
---@field public keymaps jascha030.lsp.Keymaps
---@field public config jascha030.lsp.Config
---@field public menu jascha030.lsp.ContextAwareMenu
local M = {}

M = setmetatable({}, { __index = require('jascha030.utils').create_submod_loader('jascha030.lsp', true) })

-- local methods = vim.lsp.protocol.Methods
local md_namespace = vim.api.nvim_create_namespace('jascha030/lsp_float')

-- Adds extra inline highlights to the given buffer.
---@param buf integer
local function add_inline_highlights(buf)
    local patterns = {
        ['@%S+'] = '@parameter',
        ['^%s*(Parameters:)'] = '@text.title',
        ['^%s*(Return:)'] = '@text.title',
        ['^%s*(See also:)'] = '@text.title',
        ['{%S-}'] = '@parameter',
    }

    for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        for pattern, hl_group in pairs(patterns) do
            ---@type integer? from
            local from, to = 1, nil
            while from do
                from, to = line:find(pattern, from)
                if from then
                    -- stylua: ignore 
                    vim.api.nvim_buf_set_extmark( buf, md_namespace, l - 1, from - 1, { end_col = to, hl_group = hl_group })
                end
                from = to and to + 1 or nil
            end
        end
    end
end

-- HACK: Override `vim.lsp.util.stylize_markdown` to use Treesitter.
---@param bufnr integer
---@param contents string[]
---@param opts table
---@return string[]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
    contents = vim.lsp.util._normalize_markdown(contents, {
        width = vim.lsp.util._make_floating_popup_size(contents, opts),
    })

    vim.bo[bufnr].filetype = 'markdown'
    vim.treesitter.start(bufnr)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
    add_inline_highlights(bufnr)

    return contents
end

local function diagnostic_signs_init()
    ---@param icon DiagnosticSignIcon
    local function define_diagnostic_icon(icon)
        vim.fn.sign_define(icon.name, { text = icon.text, texthl = icon.name, numhl = icon.name })
    end

    ---@param icon DiagnosticSignIcon
    for _, icon in pairs(require('jascha030.config.icons').get_diagnostic_signs()) do
        define_diagnostic_icon(icon)
    end
end

local function set_keymaps(client, bufnr)
    local self = M.keymaps.new(client, bufnr)
    local diagnostic_goto = M.keymaps.diagnostic_goto

    self:map('<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
    self:map('<leader>cl', 'LspInfo', { desc = 'Lsp Info' })
    self:map('<leader>xd', 'Telescope diagnostics', { desc = 'Telescope Diagnostics' })

    self:map('gd', 'Telescope lsp_definitions', { desc = 'Goto Definition' })
    self:map('gr', 'Telescope lsp_references', { desc = 'References' })
    self:map('gD', 'Telescope lsp_declarations', { desc = 'Goto Declaration' })
    self:map('gI', 'Telescope lsp_implementations', { desc = 'Goto Implementation' })
    self:map('gt', 'Telescope lsp_type_definitions', { desc = 'Goto Type Definition' })

    self:map('K', vim.lsp.buf.hover, { desc = 'Hover' })
    self:map('gK', vim.lsp.buf.signature_help, { desc = 'Signature Help', has = 'signatureHelp' })
    self:map('<C-k>', vim.lsp.buf.signature_help, { mode = 'i', desc = 'Signature Help', has = 'signatureHelp' })

    self:map(']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
    self:map('[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
    self:map(']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
    self:map('[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
    self:map(']w', diagnostic_goto(true, 'WARNING'), { desc = 'Next Warning' })
    self:map('[w', diagnostic_goto(false, 'WARNING'), { desc = 'Prev Warning' })

    self:map('<C-a>', vim.lsp.buf.code_action, { desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' })
    self:map('<leader>a', vim.lsp.buf.code_action, { desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' })
    self:map('<leader>r', M.keymaps.rename, { expr = true, desc = 'Rename', has = 'rename' })

    -- stylua: ignore
    self:map('<C-l>', function() M.format(client, bufnr) end, { desc = 'Format Document', has = 'documentFormatting' })
end

---@param on_attach fun(client, buffer)
---@param group string|nil
function M.lsp_attach(on_attach, group)
    group = group or nil

    local attach = {
        callback = function(args)
            -- stylua: ignore
            if not (args.data and args.data.client_id) then return end

            on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
        end,
    }

    if nil ~= group then
        attach.group = group
        vim.api.nvim_create_augroup(group, {})
    end

    vim.api.nvim_create_autocmd('LspAttach', attach)
end

function M.on_attach(client, buffer)
    if client.server_capabilities.completionProvider then
        vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = buffer })
    end

    vim.notify(client.name, vim.log.levels.DEBUG)

    if client.name == 'phpactor' then
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.completionProvider = false
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.implementationProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.renameProvider = false
        client.server_capabilities.selectionRangeProvider = false
        client.server_capabilities.signatureHelpProvider = false
        client.server_capabilities.typeDefinitionProvider = false
        client.server_capabilities.workspaceSymbolProvider = false
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.documentHighlightProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    M.lsp_attach(set_keymaps)
end

function M.virtual_text(opts)
    if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
        opts.diagnostics.virtual_text.prefix = vim.fn.has('nvim-0.10') == 0 and '●'
            or function(diagnostic)
                local icons = require('jascha030.config.icons').get_diagnostic_signs()

                for d, icon in pairs(icons) do
                    if diagnostic.severity == vim.diagnostic.severity[d:upper()] then ---@diagnostic disable-line
                        return icon
                    end
                end
            end
    end
end

-- Setup inlay-hints
function M.inlay_hints(opts)
    local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    if opts.inlay_hints.enabled and inlay_hint then
        M.lsp_attach(function(client, buffer)
            if client.supports_method('textDocument/inlayHint') then
                inlay_hint(buffer, true)
            end
        end)
    end

    -- Init lsp-inlayhints plugin if available
    local ok, inlay_hints_plugin = pcall(require, 'lsp-inlayhints')
    if not ok then
        return
    end

    M.lsp_attach(inlay_hints_plugin.on_attach, 'LspAttach_inlayhints')
end

function M.format(client, bufnr)
    if not client.server_capabilities.documentFormattingProvider then
        return
    end

    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(c)
            if #require('null-ls.sources').get_available(vim.bo[bufnr].filetype, 'NULL_LS_FORMATTING') > 0 then
                return c.name == 'null-ls'
            end

            return c.name ~= 'null-ls'
        end,
    })
end

function M.signature_help_handler()
    if require('jascha030.utils').has_plugin('noice.nvim') then
        return nil
    end

    return vim.lsp.with(vim.lsp.handlers.signature_help, BORDERS)
end

function M.setup(opts)
    opts = opts or {}

    diagnostic_signs_init()

    -- Configure diagnostics
    local diagnostics = vim.deepcopy(opts.diagnostics)
    vim.diagnostic.config(diagnostics)

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = BORDER })
    -- stylua: ignore
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostics)

    local signature_help = M.signature_help_handler()
    if signature_help ~= nil then
        vim.lsp.handlers['textDocument/signatureHelp'] = signature_help
    end

    -- Default on_attach handlers
    M.lsp_attach(M.on_attach)
    M.inlay_hints(opts)
    M.virtual_text(opts)
end

return M
