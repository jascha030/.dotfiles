local loaded = false
local M = {}

function M.setup()
    if loaded == true then
        return
    end

    loaded = true

    local builtins = require('null-ls').builtins
    local formatting = builtins.formatting
    local diagnostics = builtins.diagnostics
    local completion = builtins.completion

    require('null-ls').setup({
        sources = {
            formatting.stylua.with({ extra_args = { '--config-path', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' } }),
            formatting.phpcsfixer,
            diagnostics.eslint,
            completion.spell,
        },
    })
end

return M
