return {
    cmd = { 'xcrun', 'sourcekit-lsp' },
    filetypes = { 'swift', 'c', 'cpp', 'objective-c', 'objective-cpp' },
    root_markers = { 'Package.swift', '.git' },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
}
