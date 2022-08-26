local M = {}

function M.setup()
    require('fidget').setup({
        text = {
            spinner = 'dots',
        },
        window = {
            relative = 'editor',
            blend = 0,
            zindex = nil,
        },
    })
end

return M.setup
