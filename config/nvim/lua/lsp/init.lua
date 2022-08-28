local utils = require("utils")
if not utils.validate({ "lspconfig", "mason", "mason-lspconfig", "cmp_nvim_lsp", "null-ls", "rust-tools" }, "lsp") then
	return
end

local M = {}

local loaded = false
local cmp_lsp = require("cmp_nvim_lsp")
local default = require("lsp.config")
local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function get_default_server_config()
	return vim.tbl_deep_extend("force", default.server, { capabilities = capabilities })
end

local function load_server_config(server_name)
	local ok, config = pcall(require, "lsp.config." .. server_name)

	if not ok or type(config) ~= "table" then
		return get_default_server_config()
	end

	return config
end

local function get_server_config(server_name, opts)
	opts = opts or get_default_server_config()

	return vim.tbl_deep_extend("force", opts, load_server_config(server_name))
end

function M.setup_lsp(config)
	for _, sign in ipairs(config.diagnostic.signs.active) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	vim.diagnostic.config(config.diagnostic)
	vim.lsp.handlers["textDocument/hover"] = config.handlers.hover
	vim.lsp.handlers["textDocument/signatureHelp"] = config.handlers.signature_help
end

function M.setup_extensions(opts)
	local lspconfig = require("lspconfig")
	local mason = require("mason")
	local mason_lsp = require("mason-lspconfig")
	local null_ls = require("null-ls")
	local rt = require("rust-tools")

	mason.setup({})
	mason_lsp.setup(opts["mason-lspconfig"])
	mason_lsp.setup_handlers({
		function(server)
			lspconfig[server].setup(get_server_config(server))
		end,
		-- Overrides
		["rust_analyzer"] = function()
			rt.setup({ server = get_default_server_config() })
		end,
	})

	local stylua_path = os.getenv("XDG_CONFIG") .. "/stylua.toml"

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua.with({ extra_args = { "--config-path", stylua_path } }),
			null_ls.builtins.diagnostics.eslint,
			null_ls.builtins.completion.spell,
		},
	})
end

function M.init(opts)
	if loaded == true then
		return
	end

	loaded = true
	opts = vim.tbl_deep_extend("force", default, opts or default)

	M.setup_lsp(opts.lsp)
	M.setup_extensions(opts.extensions)
end

return M
