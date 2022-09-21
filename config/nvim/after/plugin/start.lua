local utils = require('utils')
local loader = require('config.loader')
local config = utils.conf

-- TODO: autoload based on files in config dir.
for _, plugin in pairs(config.plugin_configs) do
    loader.load(plugin)
end

require('lsp').setup()

utils.create_packer_cmds()