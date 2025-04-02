---@diagnostic disable: duplicate-doc-field

---@class jascha030.lsp.Module
---@field public keymaps jascha030.lsp.Keymaps
---@field public config jascha030.lsp.Config
local M = {}
local utils = require('jascha030.utils')

M = setmetatable({}, { __index = utils.create_submod_loader('jascha030.lsp', true) })

vim.lsp.config('*', {
    capabilities = require('jascha030.lsp.capabilities').make_capabilities(),
})

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
                    vim.api.nvim_buf_set_extmark(
                        buf,
                        vim.api.nvim_create_namespace('jascha030/lsp_float'),
                        l - 1,
                        from - 1,
                        { end_col = to, hl_group = hl_group }
                    )
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

    ---@diagnostic disable-next-line: inject-field
    vim.bo[bufnr].filetype = 'markdown'
    vim.treesitter.start(bufnr)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

    add_inline_highlights(bufnr)

    return contents
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

function M.virtual_text(opts)
    if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
        opts.diagnostics.virtual_text.prefix = vim.fn.has('nvim-0.10') == 0 and '●'
            or function(diagnostic)
                local icons = require('jascha030.core.icons').get_diagnostic_signs()

                for d, icon in pairs(icons) do
                    if diagnostic.severity == vim.diagnostic.severity[d:upper()] then ---@diagnostic disable-line
                        return icon
                    end
                end
            end
    end
end

function M.inlay_hints(opts)
    if not opts.inlay_hints.enabled then
        return
    end

    M.lsp_attach(function(client, _)
        if client.server_capabilities.inlayHintProvider ~= nil then
            vim.lsp.inlay_hint.enable(true)
        end
    end)

    -- Init lsp-inlayhints plugin if available
    local ok, inlayhints = pcall(require, 'lsp-inlayhints')
    if ok then
        M.lsp_attach(inlayhints.on_attach, 'LspAttach_inlayhints')
    end
end

function M.get_signature_help_handler()
    if utils.has_plugin('noice.nvim') then
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

-- Disable capabilities for certain clients
---@todo: maybe just do this per client instead of capability.
local DISABLED_CAPABILITIES_CLIENTS = {
    ['documentFormattingProvider'] = {
        'intelephense',
        'jsonls',
        'lua_ls',
    },
    ['documentRangeFormattingProvider'] = {
        'intelephense',
        'jsonls',
        'lua_ls',
    },
    ['hoverProvider'] = {
        'phpactor',
    },
    ['referencesProvider'] = {
        'phpactor',
    },
}

function M.setup(opts)
    opts = opts or {}

    -- Configure diagnostics
    ---@param icon DiagnosticSignIcon
    for _, icon in pairs(require('jascha030.core.icons').get_diagnostic_signs()) do
        vim.fn.sign_define(icon.name, { text = icon.text, texthl = icon.name, numhl = icon.name })
    end

    local diagnostics = vim.deepcopy(opts.diagnostics)
    vim.diagnostic.config(diagnostics)

    local signature_help = M.get_signature_help_handler()
    if signature_help ~= nil then
        vim.lsp.handlers['textDocument/signatureHelp'] = signature_help
    end

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = BORDER })
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(diagnostic_handler, diagnostics)

    -- Default on_attach handlers
    ---@param client vim.lsp.Client
    local on_attach = function(client, buffer)
        if client.server_capabilities.completionProvider then
            vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = buffer })
        end

        for capability, clients in pairs(DISABLED_CAPABILITIES_CLIENTS) do
            if vim.tbl_contains(clients, client.name) then
                client.server_capabilities[capability] = false
            end
        end

        if client.name == 'yamlls' then
            client.server_capabilities.documentFormattingProvider = true
        end
    end

    M.lsp_attach(on_attach)
    M.lsp_attach(M.keymaps.on_attach)
    M.inlay_hints(opts)
    M.virtual_text(opts)
end

return M
