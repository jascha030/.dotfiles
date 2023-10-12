return {
    root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'wp-config-sample.php', 'wp-config.php'),
    setup = {
        init_options = {
            -- ['language_server_phpstan.bin'] = '/Users/jaschavanaalst/.phive/phars/phpstan-1.9.6.phar',
            ['language_server_phpstan.bin'] = '%project_root%/vendor/bin/phpstan',
            ['language_server_php_cs_fixer.enabled'] = true,
            ['language_server_phpstan.enabled'] = true,
            ['language_server_php_cs_fixer.bin'] = '/Users/jaschavanaalst/tools/php-cs-fixer',
            ['language_server_php_cs_fixer.show_diagnostics'] = true,
            ['phpunit.enabled'] = true,
            ['completion.dedupe'] = true,
            ['completion.dedupe_match_fqn'] = true,
            ['composer.autoloader_path'] = { '%project_root%/vendor/autoload.php' },
            ['indexer.exclude_patterns'] = {
                '/vendor/**/Tests/**/*',
                '/vendor/**/tests/**/*',
                '/.var/cache/**/*',
                '/var/cache/**/*',
                '/vendor-bin/**/vendor/php-stubs/wordpress-stubs/wordpress-stubs.php',
            },
            ['indexer.stub_paths'] = {
                '%project_root%/vendor-bin/phpstan/vendor',
                '%project_root%/vendor-bin/stubs/vendor',
                '/Users/jaschavanaalst/.composer/vendor-bin/stubs/vendor/jetbrains/phpstorm-stubs',
                '/Users/jaschavanaalst/.composer/vendor-bin/stubs/vendor/php-stubs/wordpress-stubs',
            },
        },
    },
}
