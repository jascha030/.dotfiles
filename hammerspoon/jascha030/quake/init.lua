return {
    set = function(app, screen)
        require('jascha030.quake.tap').action = function()
            require('jascha030.quake.term').toggle(app, screen)
        end
    end,
}
