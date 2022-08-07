return function()
    local module = 'cokeline'

    require(module).setup({
        show_if_buffers_are_at_least = 2,
        buffers = {
            focus_on_delete = 'prev',
            new_buffers_position = 'next',
        },
    })
end