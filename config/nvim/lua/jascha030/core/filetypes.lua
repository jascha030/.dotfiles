local M = {}

M.initialized = false

function M.setup()
    if M.initialized == true then
        return
    end

    M.initialized = true

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
end

return M
