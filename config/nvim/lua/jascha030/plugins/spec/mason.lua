local M = {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = {
        { 'm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
    opts = {
        ensure_installed = {
            'lua-language-server',
            'rust-analyzer',
            'stylua',
            'shellcheck',
            'shfmt',
            'flake8',
            'phpactor',
        },
        ui = BORDERS,
    },
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
