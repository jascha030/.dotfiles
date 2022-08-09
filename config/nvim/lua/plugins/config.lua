local function display_open()
    return require('packer.util').float({ border = 'single' })
end

return {
    display = { open_fn = display_open },
    profile = {
        enable = true,
        threshold = 1,
    },
}
