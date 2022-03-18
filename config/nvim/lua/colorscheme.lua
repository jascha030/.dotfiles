local schemes = {
    dark = {
        scheme = 'tokyonight',
        options = {
            tokyonight_style = 'night',
            tokyonight_italic_functions = true,
        },
        option_scope = vim.g,
    },
    light = {
        scheme = 'tokyonight',
        options = {
            tokyonight_style = 'day',
            tokyonight_italic_functions = true,
        },
        option_scope = vim.g,
    },
}

if vim.g['nvim_color_scheme_toggle_current'] == nil then
    vim.g.nvim_color_scheme_toggle_current = {
        default = 'dark',
        set = nil,
        schemes = schemes,
    }

    if pcall(vim.cmd, 'colorscheme ' .. schemes.dark.scheme) then
        vim.g.nvim_color_scheme_toggle_current.set = 'dark'
    end
end

local toggle = function()
    local toggle_to = 'light'

    if vim.g.nvim_color_scheme_toggle_current.set == 'dark' then
        toggle_to = 'light'
    else
        toggle_to = 'dark'
    end

    vim.cmd('colorscheme ' .. vim.g.nvim_color_scheme_toggle_current.schemes[toggle_to].scheme)
    vim.g.nvim_color_scheme_toggle_current.set = toggle_to

    for option, value in pairs(vim.g.nvim_color_scheme_toggle_current.schemes[toggle_to].options) do
        vim.g[option] = value
    end
end

return {
    toggle = toggle,
}
