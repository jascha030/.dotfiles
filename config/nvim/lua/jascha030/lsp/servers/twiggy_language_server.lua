--[[
    export type InlayHintSettings = {
        macro: boolean,
        macroArguments: boolean,
        block: boolean,
    };

    export const enum PhpFrameworkOption {
        Ignore = 'ignore',
        Twig = 'twig',
        Symfony = 'symfony',
        Craft = 'craft',
    }

    export type PhpFramework = PhpFrameworkOption.Twig | PhpFrameworkOption.Symfony | PhpFrameworkOption.Craft;

    type DiagnosticsSettings = {
        twigCsFixer: boolean,
    };

    export type LanguageServerSettings = {
        autoInsertSpaces: boolean,
        inlayHints: InlayHintSettings,

        framework?: PhpFrameworkOption,
        phpExecutable: string,
        symfonyConsolePath: string,
        vanillaTwigEnvironmentPath: string,
        diagnostics: DiagnosticsSettings,
    };
--]]

return function()
    return {
        -- cmd = { 'twiggy-language-server', '--stdio' },
        filetypes = { 'twig' },
        root_dir = require('lspconfig.util').root_pattern('composer.json', '.git'),
        single_file_support = true,
        settings = {
            twiggy = {
                autoInsertSpaces = true,
                framework = 'twig',
                phpExecutable = '/opt/homebrew/bin/php',
                vanillaTwigEnvironmentPath = '/Users/jaschavanaalst/.development/Projects/Php/Wordpress/sites/zon-en-leven/wp-content/themes/socialbrothers/inc/twig.php',
                diagnostics = {
                    twigCsFixer = true,
                },
            },
        },
    }
    --     local root_dir = require('lspconfig.util').root_pattern('composer.json', '.git')
    --     return {
    --         cmd = { 'twiggy-language-server', '--stdio' },
    --         filetypes = { 'twig' },
    --         settings = {
    --             root_dir = root_dir,
    --             twiggy = {
    --                 framework = 'twig',
    --                 phpExecutable = '/opt/homebrew/bin/php',
    --                 vanillaTwigEnvironmentPath = '/Users/jaschavanaalst/.development/Projects/Php/Wordpress/sites/zon-en-leven/wp-content/themes/socialbrothers/inc/twig.php',
    --             },
    --         },
    --     }
end
