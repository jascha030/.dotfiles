-- Load plugin configurations in "nvim/lua/config/".
require('config.loader').load_all()

-- Setup LSP settings.
require('lsp').setup()

-- Create lazy Packer cmd replacements.
require('utils').create_packer_cmds()
