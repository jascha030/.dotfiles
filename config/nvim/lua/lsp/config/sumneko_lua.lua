local util = require('utils')
local root = os.getenv('HOME') .. '/tools/lua-language-server'
local binary = root .. '/bin/lua-language-server'

local WS = {}

function WS.in_dotfiles()
    return util.fs.cwd_in(vim.fn.expand('$DOTFILES'))
end

function WS.in_hammerspoon()
    return (util.fs.cwd_in(vim.fn.expand('$HOME/.hammerspoon')) or WS.in_dotfiles())
end

function WS.in_neovim()
    return (
        util.fs.cwd_in(vim.fn.stdpath('config'))
        or WS.in_dotfiles()
        or util.fs.cwd_in(vim.fn.expand('$HOME/.development/Projects/lua/nitepal.nvim'))
    )
end

function WS.in_wez()
    return (util.fs.cwd_in(vim.fn.expand('$HOME/.hammerspoon')) or WS.in_dotfiles())
end

function WS.in_nvim_project() end

local M = {}

function M.path()
    local path = WS.in_neovim() and vim.split(package.path, ';') or {}

    for _, p in ipairs({
        'lua/?.lua',
        'lua/?/init.lua',
    }) do
        table.insert(path, p)
    end

    return path
end

function M.library()
    local ret = {}

    local function add(lib, filter)
        for _, p in pairs(vim.fn.expand(lib .. '/lua', false, true)) do
            p = vim.loop.fs_realpath(p)

            if p and (not filter or filter[vim.fn.fnamemodify(p, ':h:t')]) then
                table.insert(ret, p)
            end
        end
    end

    local function add_plugins(plugins)
        local filter = {}

        for _, p in pairs(plugins) do
            filter[p] = true
        end

        for _, site in pairs(vim.split(vim.o.packpath, ',')) do
            add(site .. '/pack/*/opt/*', filter)
            add(site .. '/pack/*/start/*', filter)
        end
    end

    if WS.in_neovim() then
        add('$VIMRUNTIME')
        add('$HOME/.local/share/nvim/site/pack/packer/opt/lua-dev.nvim/types')

        add_plugins({
            'telescope.nvim',
            'nvim-tree.lua',
            'nvim-treesitter',
            'nvim-treesitter-context',
            'nvim-treesitter-textobjects',
            'nvim-lspconfig',
            'nvim-cokeline',
        })
    end

    if WS.in_hammerspoon() then
        add('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs')
        add('$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations')
    end

    if WS.in_wez() then
        add('$WEZTERM_CONFIG_DIR')
    end

    return ret
end

function M.version()
    local ret = { 'LuaJIT' }

    if util.tbl.tbl_length(ret) == 1 then
        return 'LuaJIT'
    end

    return ret
end

function M.globals()
    local ret = {}

    local available_globals = {
        ['vim'] = WS.in_neovim(),
        ['hs'] = WS.in_hammerspoon(),
    }

    for gv, f in pairs(available_globals) do
        if f then
            table.insert(ret, gv)
        end
    end

    return ret
end

--local hs_path = vim.split(vim.fn.system('hs -c package.path'):gsub('[\n\r]', ''), ';')

local config = {
    cmd = { binary, '-E', root .. '/main.lua' },
    settings = {
        Lua = {
            runtime = {
                version = M.version(),
                maxPreload = 1000,
                preloadFileSize = 150,
            },
            diagnostics = {
                globals = M.globals(),
            },
            workspace = {
                library = M.library(),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

return config
