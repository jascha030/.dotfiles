local wezterm = require('wezterm')

local M = {}
local DEFAULT = 'Jetbrains Mono'

local defaults = {
    size = 19,
    line_height = 1.4,
    main = DEFAULT,
    alt = DEFAULT,
    italic = DEFAULT,
    fallback_font = {
        family = 'Jetbrains Mono',
        italic = false,
        weight = 600,
    },
}

M.options = {}

local function table_merge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            if type(t1[k] or false) == 'table' then
                M.table_merge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end

    return t1
end

function M.setup(options)
    M.options = table_merge(defaults, options or {})
end

function M.extend(options)
    M.options = table_merge(M.options or defaults, options or {})
end

function M.fallback_font()
    return wezterm.font_with_fallback({
        'nonicons',
        {
            family = M.options.main,
            italic = false,
            weight = 600,
        },
        {
            family = M.options.alt,
            italic = false,
            weight = 600,
        },
        M.options.fallback_font,
    })
end

function M.get_rules()
    return {
        {
            italic = false,
            intensity = 'Normal',
            font = M.fallback_font(),
        },
        {
            italic = true,
            intensity = 'Bold',
            font = M.fallback_font(),
        },
        {
            italic = true,
            intensity = 'Normal',
            font = wezterm.font(M.options.italic, { italic = true, weight = 500 }),
        },
    }
end

M.setup()

return M
