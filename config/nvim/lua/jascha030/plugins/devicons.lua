local icons = nil

local M = {
    'yamatsum/nvim-nonicons',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    opts = {},
}

function M.setup()
    if nil == icons then
        icons = require('jascha030.devicons')
    end

   ---@diagnostic disable-next-line: undefined-field, need-check-nil 
    icons.setup(require('jascha030.config').options.devicons)

    require('nvim-web-devicons').set_up_highlights()
 
end

return M
