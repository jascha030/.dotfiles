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

return function()
    return {
        filetypes = {
            'css',
            'scss',
            'sass',
            'postcss',
            'html',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'svelte',
            'vue',
            'rust',
        },
        init_options = {
            userLanguages = {
                eelixir = 'html-eex',
                eruby = 'erb',
                rust = 'html',
            },
        },
        root_dir = require('lspconfig').util.root_pattern(
            -- 'cargo.toml',
            'tailwind.config.js',
            'tailwind.config.cjs',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.cjs',
            'postcss.config.ts'
        ),
    }
end
