vim.filetype.add({
    extension = { env = 'dotenv' },
    filename = { ['.env'] = 'dotenv' },
    pattern = {
        ['%.env%.[%w_.-]+'] = 'dotenv',
        ['.*%.blade%.php'] = 'blade',
    },
})
