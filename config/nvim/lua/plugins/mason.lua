---@type LazyPluginSpec
local M = {
    'williamboman/mason.nvim',
    cmd = { 'Mason' },
    keys = {
        { '<leader><leader>m', '<cmd>Mason<cr>', desc = 'Mason' },
    },
    opts = function(_, opts)
        opts.ensure_installed = {
            'angular-language-server',
            'bash-language-server',
            'beautysh',
            'black',
            'blade-formatter',
            'css-lsp',
            'eslint_d',
            'flake8',
            'html-lsp',
            'intelephense',
            'isort',
            'json-lsp',
            'lua-language-server',
            'luacheck',
            'markdownlint',
            'marksman',
            'phpactor',
            'phpstan',
            'psalm',
            'rust-analyzer',
            'shellcheck',
            'shfmt',
            'stylelint',
            'stylelint-lsp',
            'stylua',
            'svelte-language-server',
            'tailwindcss-language-server',
            'taplo',
            'typescript-language-server',
            'yaml-language-server',
            'yamlfix',
            'yamlfmt',
        }

        opts.ui = BORDERS

        return opts
    end,
    lazy = true,
}

function M.config(_, opts)
    require('mason').setup(opts)

    local registry = require('mason-registry')

    local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
            local p = registry.get_package(tool)

            if not p:is_installed() then
                p:install()
            end
        end
    end

    if registry.refresh then
        registry.refresh(ensure_installed)
    else
        ensure_installed()
    end

    for _, tool in ipairs(opts.ensure_installed) do
        local p = registry.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end
end

return M
