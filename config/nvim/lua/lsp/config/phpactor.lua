return {
    root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'wp-config-sample.php', 'wp-config.php'),
    setup = {
        init_options = {
            ['language_server_phpstan.enabled'] = true,
            ['language_server_phpstan.bin'] = '/Users/jaschavanaalst/.phive/phars/phpstan-1.9.6.phar',
        },
    },
}
