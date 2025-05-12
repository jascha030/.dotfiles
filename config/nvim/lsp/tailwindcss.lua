---@diagnostic disable: missing-fields
---@type vim.lsp.ClientConfig
local tailwindcss = {
    filetypes = {
        'aspnetcorerazor',
        'astro',
        'astro-markdown',
        'blade',
        'clojure',
        'django-html',
        'htmldjango',
        'edge',
        'eelixir', -- vim ft
        'elixir',
        'ejs',
        'erb',
        'eruby', -- vim ft
        'gohtml',
        'gohtmltmpl',
        'haml',
        'handlebars',
        'hbs',
        'html',
        'htmlangular',
        'html-eex',
        'heex',
        'jade',
        'leaf',
        'liquid',
        'markdown',
        'mdx',
        'mustache',
        'njk',
        'nunjucks',
        'php',
        'razor',
        'slim',
        'twig',
        -- css
        'css',
        'less',
        'postcss',
        'sass',
        'scss',
        'stylus',
        'sugarss',
        -- js
        'javascript',
        'javascriptreact',
        'reason',
        'rescript',
        'typescript',
        'typescriptreact',
        -- mixed
        'vue',
        'svelte',
        'templ',
    },
    root_dir = require('lspconfig').util.root_pattern(
        'tailwind.config.js',
        'tailwind.config.cjs',
        'tailwind.config.mjs',
        'tailwind.config.ts',
        'postcss.config.js',
        'postcss.config.cjs',
        'postcss.config.mjs',
        'postcss.config.ts'
    ),
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidConfigPath = 'error',
                invalidScreen = 'error',
                invalidTailwindDirective = 'error',
                invalidVariant = 'error',
                recommendedVariantOrder = 'warning',
                unusedClasses = 'warning',
            },
            includeLanguages = {
                css = 'css',
                javascript = 'javascript',
                javascriptreact = 'javascript',
                typescript = 'javascript',
                typescriptreact = 'javascript',
                svelte = 'html',
                vue = 'html',
                html = 'html',
                php = 'html',
                eelixir = 'html-eex',
                eruby = 'erb',
                rust = 'html',
            },
        },
    },
}

return require('jascha030.lsp').config.extend(tailwindcss)
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
--
-- if cmp_nvim_lsp_ok then
--     capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
--     capabilities.textDocument.completion.completionItem.snippetSupport = true
--     capabilities.textDocument.colorProvider = { dynamicRegistration = false }
-- end
--
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true,
-- }
--
-- return {
--     capabilities = capabilities,
--     on_attach = function(client, bufnr)
--         if client.server_capabilities.colorProvider then
--             require('colorizer').attach_to_buffer(bufnr, {
--                 mode = 'background',
--                 css = true,
--                 names = true,
--                 tailwind = true,
--             })
--         end
--     end,
-- }
