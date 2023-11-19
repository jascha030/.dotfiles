-- Context-aware menu
-- Credits to https://github.com/rafi
-- https://github.com/rafi/vim-config

---@class jascha030.lsp.ContextAwareMenu
local M = {}

---@param method string
---@diagnostic disable-next-line
---@param clients lsp.Client[]
---@return boolean
function M.supports_method(method, clients)
    for _, client in pairs(clients) do
        ---@diagnostic disable-next-line
        if client.supports_method(method) then
            return true
        end
    end

    return false
end

function M.show()
    local clients

    if vim.fn.has('nvim-0.8') ~= 1 then
        vim.notify('You must be running Neovim ≥8.0', vim.log.levels.WARN, { title = 'Contextmenu' })
        return
    end

    local cword = vim.fn.expand('<cword>')
    local bufnr = vim.api.nvim_get_current_buf()

    if vim.lsp.get_clients ~= nil then
        clients = vim.lsp.get_clients({ bufnr = bufnr })
    else
        ---@diagnostic disable-next-line: deprecated
        clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    end

    -- Remove all menu options
    pcall(vim.cmd.aunmenu, 'Context')

    -- Cursor is on blank character.
    if cword == '' then
        vim.cmd([[
			nmenu Context.Select\ All  ggVG
			nmenu Context.-1-          <Nop>
		]])
    else
        -- Add LSP methods, only if one of the servers support it.
        if M.supports_method('textDocument/declaration', clients) then
            vim.cmd('nmenu Context.Declaration <cmd>lua vim.lsp.buf.declaration()<CR>')
        end

        if M.supports_method('textDocument/definition', clients) then
            vim.cmd('nmenu Context.&Definition <cmd>lua vim.lsp.buf.definition()<CR>')
        end

        if M.supports_method('textDocument/references', clients) then
            vim.cmd('nmenu Context.&References… <cmd>lua vim.lsp.buf.references()<CR>')
        end
        if M.supports_method('textDocument/implementation', clients) then
            vim.cmd('nmenu Context.Implementation <cmd>lua vim.lsp.buf.implementation()<CR>')
        end

        if #clients > 0 then
            vim.cmd([[
				nmenu Context.-1-            <Nop>
				nmenu Context.Find\ symbol…  <cmd>lua vim.schedule(function() require'telescope.builtin'.lsp_workspace_symbols({default_text = vim.fn.expand('<cword>')}) end)<CR>
			]])
        end

        vim.cmd([[
			nmenu Context.Grep… <cmd>lua vim.schedule(function() require'telescope.builtin'.live_grep({default_text = vim.fn.expand('<cword>')}) end)<CR>
			nmenu Context.-2-   <Nop>
		]])
    end

    vim.cmd([[
		nmenu Context.Diagnostics        <cmd>Trouble<CR>
		nmenu Context.Bookmark           m;
		nmenu Context.TODOs              <cmd>TodoTrouble<CR>
		nmenu Context.Git\ diff          <cmd>Gdiffsplit<CR>
		nmenu Context.Unsaved\ diff      <cmd>DiffOrig<CR>
		nmenu Context.Open\ in\ browser  <cmd>lua require('gitlinker').get_buf_range_url('n')<CR>
	]])

    pcall(vim.cmd.popup, 'Context')
end

return M
