local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local hs_version = vim.fn.system('hs -c _VERSION'):gsub('[\n\r]', '')
local hs_path = vim.split(vim.fn.system('hs -c package.path'):gsub('[\n\r]', ''), ';')

return {
    settings = {
        Lua = {
            runtime = {
                version = hs_version,
                path = hs_path,
            },
            diagnostics = {
                globals = { 'hs', 'vim' },
            },
            workspace = {
                library = {
                    vim.api.nvim_get_runtime_file('', true),
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    [vim.fn.expand('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/')] = true,
                    os.getenv('HOME') .. '/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
