return function()
    local module = 'fidget'
    require(module).setup({
        window = {
            relative = 'win',
            blend = 100,
            zindex = nil,
        },
    })
end
