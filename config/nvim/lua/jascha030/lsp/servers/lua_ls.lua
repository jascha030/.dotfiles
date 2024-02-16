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
                completion = {
                    enable = true,
                    callSnippet = 'Replace',
                },
                telemetry = {
                    enable = false,
                },
                diagnostics = {
                    globals = globals(),
                },
                workspace = {
                    checkThirdParty = false,
                },
                hint = {
                    enable = true,
                    arrayIndex = false,
                },
            },
        },
    }

    -- Make the server aware of Neovim runtime files
    local function library()
        local ret = {
            vim.fn.stdpath('config'),
            vim.fn.stdpath('data') .. '/lazy/neodev/types/stable',
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.env.HOME .. '/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
        }

        local function add(lib, filter)
            ---@diagnostic disable-next-line: param-type-mismatch
            for _, p in ipairs(vim.fn.expand(lib .. '/lua', false, true)) do
                local plugin_name = vim.fn.fnamemodify(p, ':h:t')

                ---@diagnostic disable-next-line: cast-local-type
                p = vim.loop.fs_realpath(p)

                if p and (not filter or filter[plugin_name]) then
                    table.insert(ret, vim.fn.fnamemodify(p, ':h'))
                end
            end
        end

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
        local function path()
            local meta = '${version} ${language} ${encoding}'
            meta = meta:gsub('%${version}', 'LuaJIT')
            meta = meta:gsub('%${language}', 'en-us')
            meta = meta:gsub('%${encoding}', 'utf8')

            local runtime_path = {
                '?.lua',
                '?/init.lua',
                ('meta/%s/?.lua'):format(meta),
                ('meta/%s/?/init.lua'):format(meta),
                'library/?.lua',
                'library/?/init.lua',
                'lua/?.lua',
                'lua/?/init.lua',
            }

            -- if utils.fs.in_neovim() then
            -- runtime_path = vim.split(package.path, ';')
            -- end
            return runtime_path
        end

        return {
            version = 'LuaJIT',
            path = path(),
            pathStrict = false,
            special = {
                ['lreq'] = 'require',
            },
        }
    end

    if utils.fs.in_neovim() then
        opts = vim.tbl_deep_extend('force', opts, {
            before_init = require('neodev.lsp').before_init,
            settings = {
                Lua = {
                    runtime = get_runtime(),
                    workspace = {
                        library = library(),
                    },
                },
            },
        })
    end

    return opts
end
