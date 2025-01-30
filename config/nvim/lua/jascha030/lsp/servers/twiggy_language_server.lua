return function()
    local root_dir = require('lspconfig.util').root_pattern('composer.json', '.git')
    return {
        cmd = { 'twiggy-language-server', '--stdio' },
        filetypes = { 'twig' },
        settings = {
            root_dir = root_dir,
            twiggy = {
                framework = 'twig',
                phpExecutable = '/opt/homebrew/bin/php',
                vanillaTwigEnvironmentPath = '/Users/jaschavanaalst/.development/Projects/Php/Wordpress/sites/zon-en-leven/wp-content/themes/socialbrothers/inc/twig.php',
            },
        },
    }
end
