return function()
    require('cokeline').setup({
        show_if_buffers_are_at_least = 2,
        buffers = {
            focus_on_delete = 'prev',
            new_buffers_position = 'next',
        },
    })
end
