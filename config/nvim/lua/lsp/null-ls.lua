local null_ls = require('null-ls')
local fmt = null_ls.builtins.formatting

local sources = {
    fmt.stylua.with({
        extra_args = { '--config-path', vim.fn.expand('~/.config/stylua.toml') },
    }),
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
}

null_ls.setup({
    sources = sources,
})
