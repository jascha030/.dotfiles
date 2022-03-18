local null_ls = require("null-ls")
local fmt = null_ls.builtins.formatting

local sources = {
  fmt.stylua,
  null_ls.builtins.diagnostics.eslint,
  null_ls.builtins.completion.spell
}

null_ls.setup({
	sources = sources
})

