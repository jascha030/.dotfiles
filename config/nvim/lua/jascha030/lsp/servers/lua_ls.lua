return function()
    -- @type Utils utils
    local utils = require('jascha030.utils')

    local function globals()
        local ret = {}

        local available_globals = {
            ['vim'] = utils.fs.in_neovim(),
            ['hs'] = utils.fs.in_hammerspoon(),
        }

        for gv, f in pairs(available_globals) do
            if f then
                table.insert(ret, gv)
            end
        end

        return ret
    end

    local opts = {
        settings = {
            Lua = {
                completion = { callSnippet = 'Replace' },
                telemetry = { enable = false },
                diagnostics = { globals = globals() },
                workspace = { checkThirdParty = false },
            },
        },
    }

    -- Make the server aware of Neovim runtime files
    local function library()
        local ret = { vim.fn.stdpath('data') .. '/lazy/neodev/types/nightly' }

        local function add(lib, filter)
            for _, p in ipairs(vim.fn.expand(lib .. '/lua', false, true)) do ---@diagnostic disable-line: param-type-mismatch
                local plugin_name = vim.fn.fnamemodify(p, ':h:t')

                p = vim.loop.fs_realpath(p) ---@diagnostic disable-line: cast-local-type
                if p and (not filter or filter[plugin_name]) then
                    table.insert(ret, p)
                end
            end
        end

        add(vim.fn.stdpath('config'))
        add(vim.fn.expand('$VIMRUNTIME'))

        for _, site in pairs(vim.split(vim.o.packpath, ',')) do
            add(site .. '/pack/*/opt/*')
            add(site .. '/pack/*/start/*')
        end

        if package.loaded['lazy'] then
            for _, plugin in ipairs(require('lazy').plugins()) do
                add(plugin.dir)
            end
        end

        return ret
    end

    local function get_runtime()
        if utils.fs.in_neovim() then
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')

            return {
                version = 'LuaJIT',
                path = runtime_path,
            }
        end
    end

    if utils.fs.in_neovim() then
        return vim.tbl_deep_extend('force', opts, {
            before_init = require('neodev.lsp').before_init,
            settings = {
                Lua = {
                    runtime = get_runtime(),
                    workspace = { library = library() },
                },
            },
        })
    end

    return opts
end
