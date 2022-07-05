local UserSchemeStyles = {}

UserSchemeStyles.__index = UserSchemeStyles

function UserSchemeStyles.create(dark, light)
    local self = {
        dark = dark or 'storm',
        light = light or 'day',
    }

    return setmetatable(self, UserSchemeStyles)
end

return UserSchemeStyles
