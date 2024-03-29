local M = {}

local types = {
    apps = {
        name = 'Apps',
        mods = { 'shift', 'alt' },
        handler = function(mod, key, app)
            hs.hotkey.bind(mod, key, function()
                require('jascha030').quake.toggle(app)
            end)
        end,
    },
    control = {
        name = 'App controls',
        description = 'Bindings mapped to various actions related to specific apps and the window/layout system.',
        mods = { 'ctrl', 'alt' },
    },
    system = {
        name = 'System bindings',
        mods = { 'ctrl', 'alt', 'cmd' },
    },
}

function M.visualize(mod, key)
    local key_msg = nil

    print(hs.inspect(mod))

    for _, m in pairs(mod) do
        key_msg = not key_msg and m or key_msg .. ', ' .. m
    end

    return '[ ' .. key_msg .. ' ] + ' .. key .. '.'
end

local function default_handler(mod, key, arg)
    if arg == nil then
        return
    end

    if type(arg) ~= 'function' then
        error('Invalid argument for hotkey binding: ' .. M.visualize(mod, key))
    end

    hs.hotkey.bind(mod, key, function()
        local ok, res = pcall(arg)
        if not ok then
            error('Error processing callback for hotkey binding: ' .. M.visualize(mod, key))
        end

        return res
    end)
end

function M.setup(bindings)
    for t, values in pairs(bindings) do
        if types[t] ~= nil then
            local type = types[t]
            local method = type.handler or default_handler

            for key, action in pairs(values) do
                pcall(method, type.mods, key, action)
            end
        end
    end
end

return M
