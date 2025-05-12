return require('jascha030.lsp').config.extend({
    root_dir = require('lspconfig.util').root_pattern('.git', 'wp-config-sample.php', 'wp-config.php', 'composer.json'),
    single_file_support = true,
})
