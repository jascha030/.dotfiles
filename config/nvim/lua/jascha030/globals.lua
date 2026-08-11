BORDER = 'rounded'

_G.lreq = require('lreq')

local icons = lreq('jascha030.core.icons')

_G.Jascha030 = {
    icons = {
        ---@return table<string, string>
        get_icons = function()
            return icons.get_icons()
        end,
    },
}
