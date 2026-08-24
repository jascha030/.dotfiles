-- Runs through lazy.nvim spec
return {
    setup = function(_)
        require('config.options')
        require('config.keymaps')
    end,
}
