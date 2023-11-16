local M = {
    'folke/neodev.nvim',
    name = 'neodev',
    opts = function()
        return {
            pathStrict = false,
            -- override = function(root_dir, options)
            --     local util = require('neodev.util')
            --     -- local util = require('neodev.util')
            --
            --     if util.has_file(root_dir, '~/.config/nvim') or util.has_file(root_dir, '~/.dotfiles') then
            --         options.enabled = true
            --         options.plugins = true
            --     end
            -- end,
            override = function(_, library)
                library.enabled = true
                library.plugins = true
            end,
            -- setup_jsonls = false,
            -- lspconfig = true,
        }
    end,
}

-- function M.config(_, opts)
--     require('neodev').setup(opts)
-- end

return M
