vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('ZshLocalSymbolsCache', {}),
    callback = function(args)
        local zsh_symbols = require('jascha030.zsh_symbols')
        local path = vim.api.nvim_buf_get_name(args.buf)

        if zsh_symbols.is_repo_zsh_path(path) then
            zsh_symbols.invalidate()
        end
    end,
})

return Jascha030.lsp.config_extend({
    filetypes = { 'zsh' },
    root_dir = function(bufnr, on_dir)
        local zsh_symbols = require('jascha030.zsh_symbols')
        local path = vim.api.nvim_buf_get_name(bufnr)

        if zsh_symbols.is_repo_zsh_path(path) then
            on_dir(zsh_symbols.root())
        end
    end,
    cmd = function(dispatchers, config)
        return require('jascha030.zsh_symbols.lsp').start(dispatchers, config)
    end,
})
