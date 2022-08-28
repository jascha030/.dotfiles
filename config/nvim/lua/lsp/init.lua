local M = {}

local loaded = false

local cmp_lsp = require('cmp_nvim_lsp')
local server_defaults = {
    on_attach = require('lsp.on_attach'),
    capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = { debounce_text = 150 },
}

local function load_server_config(server_name)
    local ok, config = pcall(require, 'lsp.config.' .. server_name)

    if not ok or type(config) ~= 'table' then
        return server_defaults
    end

    return config
end

local function get_server_config(server_name, opts)
    opts = opts or server_defaults

    return vim.tbl_deep_extend('force', opts, load_server_config(server_name))
end

local function init()
    local lspconfig = require('lspconfig')
    local mason_lsp = require('mason-lspconfig')
    local rt = require('rust-tools')

    local stylua_path = os.getenv('XDG_CONFIG') .. '/stylua.toml'
    local null_ls = require('null-ls')

    require('mason').setup({})
    mason_lsp.setup({
        ensure_installed = {
            'bashls',
            'intelephense',
            'rust_analyzer',
            'sumneko_lua',
        },
    })

    mason_lsp.setup_handlers({
        function(server)
            lspconfig[server].setup(get_server_config(server))
        end,
        -- Overrides
        ['rust_analyzer'] = function()
            rt.setup({ server = server_defaults })
        end,
    })
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua.with({ extra_args = { '--config-path', stylua_path } }),
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.completion.spell,
        },
    })
end

function M.init()
    init()
end

return M
