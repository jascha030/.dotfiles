-- Load plugin configurations in "nvim/lua/config/".
require('config.loader').load_all()
-- Setup LSP settings.
require('lsp').setup()
