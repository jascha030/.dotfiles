local M = {}

local types = {
    apps = {
        name = 'Apps',
        description = 'Show, hide or open various apps.',
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
        description = 'Uncommon key-mod bindings for system opts or actions with potentially unwanted side-effects.',
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

function M.setup(bindings, setup_callback)
    local f
    for t, values in pairs(bindings) do
        if types[t] ~= nil then
            local type = types[t]
            local method = type.handler or default_handler

            for key, action in pairs(values) do
                f = function()
                    setup_callback()
                    pcall(action)
                end

                pcall(method, type.mods, key, f)
            end
        end
    end
end

return M
