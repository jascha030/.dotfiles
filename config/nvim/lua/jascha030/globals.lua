-- local modules = vim.iter(vim.api.nvim_get_runtime_file('/lua/jascha030/core/*.lua', true)):map(function(path)
--     return vim.fs.basename(path):match('^(.*)%.lua$')
-- end)

_G.lreq = require('lreq')

local lsp = lreq('jascha030.lsp')

_G.Jascha030 = {
    lsp = {
        ---@param config vim.lsp.ClientConfig
        ---@return vim.lsp.ClientConfig
        config_extend = function(config)
            return lsp.config.extend(config)
        end,
    },
}

-- __index = function(_, key)
--     if vim.tbl_contains(modules, 'lua/jascha030/core/' .. key .. '.lua') then
--         return lreq('jascha030.core.' .. key)
--     end
-- end,
