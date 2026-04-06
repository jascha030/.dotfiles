---@diagnostic disable: missing-fields
return Jascha030.lsp.config_extend({
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = 'typescript-svelte-plugin',
                        location = vim.fs.normalize(
                            vim.fn.stdpath('data')
                                .. '/mason/packages/'
                                .. 'svelte-language-server'
                                .. '/node_modules/typescript-svelte-plugin'
                        ),
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
        },
        svelte = {
            plugin = {
                typescript = {
                    enable = true,
                    diagnostics = { enable = true },
                    codeActions = { enable = true },
                    hover = { enable = true },
                    completions = { enable = true },
                    definitions = { enable = true },
                },
                svelte = {
                    compilerOptions = {
                        generate = 'dom',
                        dev = true,
                    },
                    enable = true,
                    diagnostics = { enable = true },
                    codeActions = { enable = true },
                    hover = { enable = true },
                    completions = { enable = true },
                    format = { enable = true },
                },
            },
        },
    },
    on_attach = function(client, _)
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            group = vim.api.nvim_create_augroup('lsp.svelte', {}),
            pattern = { '*.js', '*.ts' },
            callback = function(ctx)
                -- internal API to sync changes that have not yet been saved to the file system
                client:notify('$/onDidChangeTsOrJsFile', {
                    uri = ctx.match,
                })
            end,
        })
    end,
})
