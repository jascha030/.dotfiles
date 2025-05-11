return function()
    return {
        cmd = { 'xcrun', 'sourcekit-lsp' },
        filetypes = { 'swift', 'c', 'cpp', 'objective-c', 'objective-cpp' },
        root_dir = require('lspconfig.util').root_pattern('Package.swift', '.git'),
        capabilities = {
            workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true,
                },
            },
        },
    }
end
