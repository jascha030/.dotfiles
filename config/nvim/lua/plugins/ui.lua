local M = {}

function M.cokeline()
    require('cokeline').setup({
        show_if_buffers_are_at_least = 2,
        buffers = {
            focus_on_delete = 'prev',
            new_buffers_position = 'next',
        },
    })
end

function M.lualine()
    require('lualine').setup({
        options = {
            icons_enabled = true,
            theme = 'tokyonight',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'NvimTree' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    })
end

function M.scrollbar()
    local colors = require('tokyonight.colors').setup({})
    --local user_colors = require('scheme.colors.jassie030')

    require('scrollbar').setup({
        handle = {
            --color = user_colors[DarkmodeEnabled() and 'dark' or 'light'],
        },
        marks = {
            Search = { color = colors.orange },
            Error = { color = colors.error },
            Warn = { color = colors.warning },
            Info = { color = colors.info },
            Hint = { color = colors.hint },
            Misc = { color = colors.purple },
        },
    })
end

function M.colorizer()
    require('colorizer').setup()
end

return M
