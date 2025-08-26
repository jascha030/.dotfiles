return {
    settings = {
        Lua = {
            runtime = {
                special = {
                    ['lreq'] = 'require',
                },
            },
            diagnostics = {
                globals = { 'hs', 'spoon', 'vim' },
            },
        },
    },
}
