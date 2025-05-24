---@diagnostic disable: missing-fields
return Jascha030.lsp.config_extend({
    root_markers = {
        '.git',
        'composer.json',
        'wp-config-sample.php',
        'wp-config.php',
    },
    -- root_dir = require('lspconfig.util').root_pattern('.git', 'wp-config-sample.php', 'wp-config.php', 'composer.json'),
    single_file_support = true,
})
