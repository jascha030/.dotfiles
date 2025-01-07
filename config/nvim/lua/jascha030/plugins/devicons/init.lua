local M = {
    -- 'nvim-tree/nvim-web-devicons',
    'yamatsum/nvim-nonicons',
    -- lazy = false,
    event = 'VeryLazy',
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
                icon = 'telescope',
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
    require('jascha030.plugins.devicons.config').setup(opts)
end

return M
