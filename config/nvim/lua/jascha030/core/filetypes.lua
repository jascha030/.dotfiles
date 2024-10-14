local M = {}

M.initialized = false

function M.setup()
    if M.initialized == true then
        return
    end

    vim.filetype.add({
        extension = {
            env = 'dotenv',
        },
        filename = {
            ['.env'] = 'dotenv',
        },
        pattern = {
            ['%.env%.[%w_.-]+'] = 'dotenv',
            ['.*%.blade%.php'] = 'blade',
        },
    })

    M.initialized = true
end

return M
