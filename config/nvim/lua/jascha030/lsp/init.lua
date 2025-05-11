---@diagnostic disable: duplicate-doc-field

---@class jascha030.lsp.Module
---@field public keymaps jascha030.lsp.Keymaps
---@field public config jascha030.lsp.Config
local M = {}

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

return setmetatable(M, {
    __index = require('jascha030.utils').create_submod_loader('jascha030.lsp', true),
})
