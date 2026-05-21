local defaults = {
    ['Brewfile'] = {
        icon = '',
    },
    ['.gitattributes'] = {
        icon = '',
        name = 'GitAttributes',
    },
    ['.gitconfig'] = {
        icon = '',
        name = 'GitConfig',
    },
    ['.gitignore'] = {
        icon = '',
        name = 'GitIgnore',
    },
    ['.gvimrc'] = {
        icon = '',
        name = 'Gvimrc',
    },
    ['.npmignore'] = {
        icon = '',
        name = 'NPMIgnore',
    },
    ['.vimrc'] = {
        icon = '',
        name = 'Vimrc',
    },
    ['.zshrc'] = {
        icon = '',
        name = 'Zshrc',
    },
    Dockerfile = {
        icon = '',
        name = 'Dockerfile',
    },
    ['Gemfile$'] = {
        icon = '',
        name = 'Gemfile',
    },
    LICENSE = {
        icon = '',
        name = 'License',
    },
    bash = {
        icon = '',
        name = 'Bash',
    },
    c = {
        icon = '',
        name = 'C',
    },
    ['c++'] = {
        icon = '',
        name = 'CPlusPlus',
    },
    cc = {
        icon = '',
        name = 'CPlusPlus',
    },
    conf = {
        icon = '',
        name = 'Conf',
    },
    cp = {
        icon = '',
        name = 'Cp',
    },
    cpp = {
        icon = '',
        name = 'Cpp',
    },
    css = {
        icon = '',
        name = 'Css',
    },
    dart = {
        icon = '',
        name = 'Dart',
    },
    db = {
        icon = '',
        name = 'Db',
    },
    dockerfile = {
        icon = '',
        name = 'Dockerfile',
    },
    fish = {
        icon = '',
        name = 'Fish',
    },
    git = {
        icon = '',
        name = 'GitLogo',
    },
    go = {
        icon = '',
        name = 'Go',
    },
    htm = {
        icon = '',
        name = 'Htm',
    },
    html = {
        icon = '',
        name = 'Html',
    },
    ico = {
        icon = '',
        name = 'Ico',
    },
    java = {
        icon = '',
        name = 'Java',
    },
    jpeg = {
        icon = '',
        name = 'Jpeg',
    },
    jpg = {
        icon = '',
        name = 'Jpg',
    },
    js = {
        icon = '',
        name = 'Js',
    },
    json = {
        icon = '',
        name = 'Json',
    },
    jsx = {
        icon = '',
        name = 'Jsx',
    },
    license = {
        icon = '',
        name = 'License',
    },
    lua = {
        icon = '',
        name = 'Lua',
    },
    makefile = {
        icon = '',
        name = 'Makefile',
    },
    markdown = {
        icon = '',
        name = 'Markdown',
    },
    md = {
        icon = '',
        name = 'Md',
    },
    mdx = {
        icon = '',
        name = 'Mdx',
    },
    node_modules = {
        icon = '',
        name = 'NodeModules',
    },
    ['package-lock.json'] = {
        icon = '',
        name = 'PackageLockJson',
    },
    ['package.json'] = {
        icon = '',
        name = 'PackageJson',
    },
    php = {
        icon = '',
        name = 'Php',
    },
    pl = {
        icon = '',
        name = 'Pl',
    },
    png = {
        icon = '',
        name = 'Png',
    },
    py = {
        icon = '',
        name = 'Py',
    },
    pyc = {
        icon = '',
        name = 'Pyc',
    },
    pyd = {
        icon = '',
        name = 'Pyd',
    },
    pyo = {
        icon = '',
        name = 'Pyo',
    },
    r = {
        icon = '',
        name = 'R',
    },
    rake = {
        icon = '',
        name = 'Rake',
    },
    rakefile = {
        icon = '',
        name = 'Rakefile',
    },
    rb = {
        icon = '',
        name = 'Rb',
    },
    rs = {
        icon = '',
        name = 'Rs',
    },
    rss = {
        icon = '',
        name = 'Rss',
    },
    scala = {
        icon = '',
        name = 'Scala',
    },
    sh = {
        icon = '',
        name = 'Sh',
    },
    sql = {
        icon = '',
        name = 'Sql',
    },
    svg = {
        icon = '',
        name = 'Svg',
    },
    swift = {
        icon = '',
        name = 'Swift',
    },
    terminal = {
        icon = '',
        name = 'Terminal',
    },
    toml = {
        icon = '',
        name = 'Toml',
    },
    ts = {
        icon = '',
        name = 'Ts',
    },
    tsx = {
        icon = '',
        name = 'Tsx',
    },
    vim = {
        icon = '',
        name = 'Vim',
    },
    vue = {
        icon = '',
        name = 'Vue',
    },
    webp = {
        icon = '',
        name = 'Webp',
    },
    yaml = {
        icon = '',
        name = 'Yaml',
    },
    yml = {
        icon = '',
        name = 'Yml',
    },
    zsh = {
        icon = '',
        name = 'Zsh',
    },
}

---@class IconConfig
local icon_config_defaults = {
    default_icon = nil,
    icons = {},
    overrides = {},
}

---@class IconsModule
---@field public options IconConfig
local Config = { devicons = {} }

local devicons = lreq('nvim-web-devicons')

function Config.get_icon(name)
    if not Config.options.icons[name] then
        error('No icon defined for ' .. name)
    end

    return Config.options.icons[name]
end

function Config.create(icon, name)
    return { icon = Config.get_icon(icon), name = name }
end

function Config.add(icon, name, filetype)
    if type(filetype) == 'string' then
        Config.devicons[filetype] = Config.create(icon, name)
    end

    if type(filetype) == 'table' then
        for prefix, type in pairs(filetype) do
            Config.add(icon, prefix .. name, type)
        end
    end
end

Config.options = {}

function Config.init()
    ---@diagnostic disable-next-line: undefined-field, need-check-nil
    devicons.refresh()
    devicons.set_icon(Config.devicons)
end

function Config.setup(options)
    Config.options = vim.tbl_deep_extend('force', icon_config_defaults, options)

    for name, devicon in pairs(Config.options.overrides) do
        Config.add(devicon.icon, name, devicon.filetypes)
    end

    Config.devicons = vim.tbl_deep_extend('force', defaults, Config.devicons)

    devicons.setup(Config.options)
    Config.init()
end

---@type LazyPluginSpec
local M = {
    'yamatsum/nvim-nonicons',
    lazy = false,
    priority = 1100,
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
    },
}

function M.opts()
    return {
        icons = require('jascha030.core.icons').get_icons(),
        default_icon = '',
        overrides = {
            Alias = {
                icon = 'alias',
                filetypes = 'aliases',
            },
            Autols = {
                icon = 'fileinfo',
                filetypes = 'auto-ls',
            },
            ZshOverrides = {
                icon = 'alias',
                filetypes = 'overrides',
            },
            Ignore = {
                icon = 'ignore',
                filetypes = {
                    Git = '.gitignore',
                    GlobalGit = 'gitignore_global',
                    Stylua = '.styluaignore',
                },
            },
            GitConfig = {
                icon = 'git',
                filetypes = {
                    Default = '.gitconfig',
                    Dotfile = 'gitconfig',
                },
            },
            EditorConfig = {
                icon = 'editor',
                filetypes = '.editorconfig',
            },
            Zshrc = {
                icon = 'term',
                filetypes = '.zshrc',
            },
            Antigenrc = {
                icon = 'term',
                filetypes = '.antigenrc',
            },
            Zshenv = {
                icon = 'term',
                filetypes = '.zshenv',
            },
            Init = {
                icon = 'init',
                filetypes = 'init',
            },
            InitLua = {
                icon = 'init',
                filetypes = 'init.lua',
            },
            MacOs = {
                icon = 'finder',
                filetypes = '.macos',
            },
            Fzf = {
                icon = 'picker',
                filetypes = 'fzf',
            },
            Hushlogin = {
                icon = 'mute',
                filetypes = 'hushlogin',
            },
            MyCnf = {
                icon = 'database',
                filetypes = 'my.cnf',
            },
            README = {
                icon = 'documentation',
                filetypes = 'README.md',
            },
            Starship = {
                icon = 'rocket',
                filetypes = 'starship.toml',
            },
            NvmRc = {
                icon = 'npm',
                filetypes = '.nvmrc',
            },
            Lockfile = {
                icon = 'lockfile',
                filetypes = '.lock',
            },
            BitbucketPipeline = {
                icon = 'bitbucket',
                filetypes = 'bitbucket-pipelines.yml',
            },
            Composer = {
                icon = 'composer',
                filetypes = 'composer.json',
            },
            PluginsSpec = {
                icon = 'list',
                filetypes = 'plugins-spec',
            },
            Prompt = {
                icon = 'rocket',
                filetypes = 'prompt',
            },
            Neon = {
                icon = 'nmode',
                filetypes = 'neon',
            },
            DistFile = {
                icon = 'package',
                filetypes = '.dist',
            },
        },
    }
end

function M.config(_, opts)
    Config.setup(opts)
end

---Refresh devicons after a theme change.
---@diagnostic disable-next-line: inject-field
function M.refresh()
    Config.init()
end

return M
