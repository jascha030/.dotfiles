return function()
    local module = 'fidget'

    require(module).setup({
        text = {
            spinner = 'dots',
        },
        window = {
            relative = 'editor',
            blend = 0,
            zindex = nil,
        },
    })

    local colors = require('colors').get_colors()

    vim.cmd('hi FidgetTitle guifg=' .. colors.red)
    vim.cmd('hi FidgetTask guibg=' .. colors.bg)
end
