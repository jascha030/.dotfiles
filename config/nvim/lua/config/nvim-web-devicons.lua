local utils, config = nil, nil

return function()
    if utils == nil then
        utils = require('utils')
        config = utils.conf
    end

    utils.icons.setup(config.devicons)

    require('nvim-web-devicons').set_up_highlights()
end
