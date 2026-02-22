--[[
-- Alternative [b]ackgrounds/[f]oregrounds
    [b] "#e7e9ef",
    [b] "#D8DEE9",
    [b] '#DFE1E8',
    [b] '#c9c9e9',
    [b] "#f0e9e9",
    [f] "#444a73",
    [f] '#40456D',
--]]
local M = {
    colors = {
        black = '#3a4f7a',        -- was #32466e (brightened slightly)
        red = '#ea1479',          -- unchanged (works in both modes)
        green = '#2da44e',        -- unchanged (works in both modes)
        yellow = '#f0c000',       -- was #ffcc00 (darkened to work in light mode)
        blue = '#4a63b0',         -- was #3d59a1 (brightened slightly)
        magenta = '#8052d4',      -- was #6f42c1 (brightened)
        cyan = '#0d7a8f',         -- was #0a6e81 (brightened slightly)
        white = '#969ac9',        -- unchanged (works in both modes)


        bright_black = '#4f6490',  -- was #465a82 (brightened)
        bright_red = '#f070a8',    -- was #f47cb4 (darkened slightly)
        bright_green = '#85c55a',  -- was #9ece6a (darkened)
        bright_yellow = '#ffaa00', -- was #ffae31 (darkened)
        bright_blue = '#8494FF',   -- unchanged (works in both modes)
        bright_magenta = '#a888e6', -- was #bb9af7 (darkened)
        bright_cyan = '#1abc9c',   -- unchanged (works in both modes)
        bright_white = '#e8e8e8',  -- was #fffcfc (darkened significantly)

        alt_black = '#3a4f7a',     -- same as black
        alt_red = '#ff007c',       -- unchanged (works in both modes)
        alt_green = '#7acc35',     -- was #8fd742 (darkened)
        alt_yellow = '#ff8000',    -- unchanged (works in both modes)
        alt_blue = '#2090ff',      -- was #0083f7 (brightened)
        alt_magenta = '#7070ff',   -- was #5f5fec (brightened)
        alt_white = '#6183bb',     -- unchanged (works in both modes)

        none = 'NONE',

        additional = {
            git_orange = '#f05033',  -- unchanged (works in both modes)
        },
    },
    variants = {
        light = {
            background = '#e0e1eb',
            background_tab = '#d0d2e1', -- Darkened from background
            foreground_tab = '#3a4f7a', -- @black
            foreground = '#40456d',
            selection_bg = '#c8c3ff',
            selection_fg = '#e7e9ee',
        },
        dark = {
            background = '#1e2030',
            background_tab = '#2d3049', -- Brightened from background
            foreground_tab = '#969ac9', -- @white
            foreground = '#c8d3f5',
            selection_bg = '#364A82',
            selection_fg = '#c8d3f5',
        },
    },
}

function M.merge_colors(types, shared)
    local scheme = {}

    for type, values in pairs(types) do
        for c, v in pairs(shared) do
            values[c] = v
        end
        scheme[type] = values
    end

    return scheme
end

function M.get_scheme()
    return M.merge_colors(M.variants, M.colors)
end

return M
