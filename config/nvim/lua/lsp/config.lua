if not require("utils").validate({ "null-ls" }, "lsp.config") then
	return
end

local function on_attach(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
	vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.keymap.set("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
	vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			vim.diagnostic.open_float(nil, {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			})
		end,
	})

	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[hi LspReferenceRead cterm=bold ctermbg=red guibg=Yellow
            hi LspReferenceText cterm=bold ctermbg=red guibg=Yellow
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=Yellow]],
			false
		)
	end

	if client == "rust_analyzer" then
		local rt = require("rust-tools")
		vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
		vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
	end
end

local M = {
	lsp = {
		diagnostic = {
			signs = {
				active = {
					{ name = "DiagnosticSignError", text = "" },
					{ name = "DiagnosticSignWarn", text = "" },
					{ name = "DiagnosticSignHint", text = "" },
					{ name = "DiagnosticSignInfo", text = "" },
				},
			},
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
			},
			virtual_text = true,
			update_in_insert = true,
			underline = true,
			severity_sort = true,
		},
		handlers = {
			options = { border = "rounded" },
			hover = {},
			signature_help = {},
		},
	},
	server = {
		on_attach = on_attach,
		capabilities = {},
		flags = { debounce_text = 150 },
	},
	extensions = {
		-- ['mason'] = {},
		["mason-lspconfig"] = {
			ensure_installed = {
				"bashls",
				"intelephense",
				"rust_analyzer",
				"sumneko_lua",
			},
		},
	},
}

M.lsp.handlers.hover = vim.lsp.with(vim.lsp.handlers.hover, M.lsp.handlers.options)
M.lsp.handlers.signature_help = vim.lsp.with(vim.lsp.handlers.signature_help, M.lsp.handlers.options)

return M
