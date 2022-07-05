local UserSchemeOverRides = {
    light = {},
    dark = {},
}

UserSchemeOverRides.__index = UserSchemeOverRides

function UserSchemeOverRides.create(dark, light)
    local self = {
        dark = dark or {},
        light = light or {},
    }

    return setmetatable(self, UserSchemeOverRides)
end

return UserSchemeOverRides
