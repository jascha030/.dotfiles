---@class lspconfig.settings.twiggy_language_server.Twiggy.InlayHints
---@field macro? boolean
---@field macroArguments? boolean
---@field block? boolean

---@class lspconfig.settings.twiggy_language_server.Twiggy.Diagnostics
---@field twigCsFixer? boolean

---@class lspconfig.settings.twiggy_language_server.Twiggy
---@field autoInsertSpaces? boolean
---@field inlayHints? lspconfig.settings.twiggy_language_server.Twiggy.InlayHints
---@field framework? 'ignore'|'twig'|'symfony'|'craft'
---@field phpExecutable? string
---@field symfonyConsolePath? string
---@field vanillaTwigEnvironmentPath? string
---@field diagnostics? lspconfig.settings.twiggy_language_server.Twiggy.Diagnostics

---@class lspconfig.settings.twiggy_language_server
---@field twiggy? lspconfig.settings.twiggy_language_server.Twiggy

---@type vim.lsp.Config
return {
    filetypes = { 'twig' },
    root_markers = { 'composer.json', '.git' },
    single_file_support = true,
    ---@type lspconfig.settings.twiggy_language_server
    settings = {
        twiggy = {
            autoInsertSpaces = true,
            framework = 'twig',
            -- phpExecutable = '/opt/homebrew/bin/php',
            -- vanillaTwigEnvironmentPath = '/Users/jaschavanaalst/.development/Projects/Php/Wordpress/sites/zon-en-leven/wp-content/themes/socialbrothers/inc/twig.php',
            diagnostics = { twigCsFixer = true },
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
