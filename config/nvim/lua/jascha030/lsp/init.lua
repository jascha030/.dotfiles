---@class jascha030.lsp.Module
---@field public keymaps jascha030.lsp.Keymaps
---@field public config jascha030.lsp.Config
---@field public menu jascha030.lsp.ContextAwareMenu
local M = {}

local utils = require('jascha030.utils')

M = setmetatable({}, {
    __index = utils.create_submod_loader('jascha030.lsp', true),
})

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
        vim.fn.sign_define(icon.name, {
            text = icon.text,
            texthl = icon.name,
            numhl = icon.name,
        })
    end

    ---@param icon DiagnosticSignIcon
    for _, icon in pairs(require('jascha030.config.icons').get_diagnostic_signs()) do
        define_diagnostic_icon(icon)
    end
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

    if client.name == 'phpactor' then
        client.server_capabilities.hoverProvider = false
    end

    M.lsp_attach(M.keymaps.on_attach)
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
    if not opts.inlay_hints.enabled then
        return
    end

    local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    M.lsp_attach(function(client, buffer)
        if client.server_capabilities.inlayHintProvider and inlay_hint then
            inlay_hint.enable(buffer, true)
        end

        -- Init lsp-inlayhints plugin if available
        local ok, inlay_hints_plugin = pcall(require, 'lsp-inlayhints')
        if ok then
            return
        end

        M.lsp_attach(function(client, buffer)
            inlay_hints_plugin.on_attach(client, buffer)
        end, 'LspAttach_inlayhints')
    end)
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

local function diagnostic_handler(_, result, ctx, config)
    result.diagnostics = vim.tbl_filter(function(diagnostic)
        return diagnostic.source ~= 'phpactor'
    end, result.diagnostics)

    vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

function M.setup(opts)
    opts = opts or {}

    diagnostic_signs_init()

    -- Configure diagnostics
    local diagnostics = vim.deepcopy(opts.diagnostics)
    vim.diagnostic.config(diagnostics)

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = BORDER })
    -- stylua: ignore
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(diagnostic_handler, diagnostics)

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
