return {
    colorscheme = 'nitepal',
    options = {
        opt = {
            mouse = 'nvi',
            termguicolors = true,
            incsearch = true,
            colorcolumn = '120',
            backspace = 'indent,eol,start',
            fileencoding = 'utf-8',
            fillchars = 'eob: ,msgsep:‾',
            scrolloff = 5,
            showtabline = 2,
            tabstop = 4,
            shiftwidth = 4,
            expandtab = true,
            smartindent = true,
            number = true,
            cursorline = true,
            modifiable = true,
            updatetime = 400,
            signcolumn = 'yes',
            rnu = true,
            shell = '/bin/zsh',
        },
        g = {
            gitblame_display_virtual_text = 0 -- Disable virtual text
        }
    },
    keymaps = {
        ['n'] = {
            ['ff'] = { ':lua require("telescope.builtin").find_files()<CR>' },
            ['FF'] = { ':lua require("telescope").extensions.file_browser.file_browser()<CR>' },
            ['fg'] = { ':lua require("telescope.builtin").live_grep()<CR>' },
            ['<C-f>'] = { ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>' },
            ['<C-l>'] = { ':lua vim.lsp.buf.formatting()<CR>' },
            ['<S-Tab>'] = { '<Plug>(cokeline-focus-next)', { silent = true } },
            ['<C-w><C-c>'] = { '<cmd>close<CR>' },
            ['<C-n>'] = { '<cmd>NvimTreeToggle<CR>' },
            ['N'] = { '<cmd>NvimTreeFocus<CR>' },
            ['ss'] = { '<cmd>Telescope<CR>' },
            ['TT'] = { '<cmd>TroubleToggle<CR>' },
            ['<Tab><Tab>'] = { '<cmd>HopWord<CR>' },
            ['sR'] = { '<cmd>source $MYVIMRC<CR>', { noremap = true, silent = true } },
            ['<C-t>'] = { '<cmd>FloatermToggle[!]<CR>' },
            ['m'] = { '<cmd>Mason<CR>' },
            ['<C-_>'] = { '<cmd>CommentToggle<CR>' },
            ['<leader>CP'] = { '<cmd>PickColor<CR>' },
            ['<leader>pc'] = { '<cmd>PackerCompile<CR>' },
            ['<leader>pu'] = { '<cmd>PackerUpdate<CR>' },
            ['<leader>pi'] = { '<cmd>PackerInstall<CR>' },
            -- TreeSitter
            ['<leader>tc'] = { '<cmd>TSHighlightCapturesUnderCursor<CR>' },
            ['<leader>p'] = { '<cmd>TSPlaygroundToggle<CR>' },
        },
        ['v'] = {
            ['<C-c>'] = { ':OSCYank<CR>' },
            ['<C-_>'] = { ":'<,'>CommentToggle<CR>" },
        },
        ['t'] = {
            ['<C-t>'] = { '<C-\\><C-n> :FloatermToggle[!]<CR>' },
            ['<M-[>'] = { '<Esc>' },
            ['<C-v><Esc>'] = { '<Esc>' },
        },
        ['i'] = {
            ['<C-p><C-p>'] = { '<cmd>PickColorInsert<CR>' },
        },
    },
    devicons = {
        default_icon = '',
        icons = {
            alias = '',
            asterisk = '',
            bookmark = '',
            brush = '',
            calendar = '',
            composer = '',
            computer = '',
            database = '',
            documentation = '',
            editor = '',
            fileinfo = '',
            finder = '',
            git = '',
            git_sync = '',
            git_branch = '',
            git_merge = '',
            git_reject = '',
            ignore = '',
            init = '⏻',
            key = '',
            list = '',
            loadspeaker = '',
            mac = '',
            mute = '',
            npm = '',
            pin = '',
            rocket = '',
            scholar = '',
            telescope = ' ',
            term = '',
            wrench = '',
            lockfile = '',
            bitbucket = '',
        },
        colors = require('nitepal.utils.palette').get_colors()[vim.o.background or 'dark'],
        overrides = {
            ['Alias'] = {
                icon = 'alias',
                color = 'yellow',
                filetypes = 'aliases',
            },
            ['Autols'] = {
                icon = 'fileinfo',
                color = 'cyan',
                filetypes = 'auto-ls',
            },

            ['Ignore'] = {
                icon = 'ignore',
                color = 'black',
                filetypes = {
                    ['Git'] = '.gitignore',
                    ['GlobalGit'] = 'gitignore_global',
                    ['Stylua'] = '.styluaignore',
                },
            },
            ['GitConfig'] = {
                icon = 'git',
                color = 'orange',
                filetypes = {
                    ['Default'] = '.gitconfig',
                    ['Dotfile'] = 'gitconfig',
                },
            },
            ['EditorConfig'] = {
                icon = 'editor',
                color = 'yellow',
                filetypes = '.editorconfig',
            },
            ['Zshrc'] = {
                icon = 'term',
                color = 'magenta',
                filetypes = '.zshrc',
            },
            ['Antigenrc'] = {
                icon = 'term',
                color = 'yellow',
                filetypes = '.antigenrc',
            },
            ['Zshenv'] = {
                icon = 'term',
                color = 'magenta',
                filetypes = '.zshenv',
            },
            ['Init'] = {
                icon = 'init',
                color = 'red',
                filetypes = 'init',
            },
            ['InitLua'] = {
                icon = 'init',
                color = 'magenta',
                filetypes = 'init.lua',
            },
            ['MacOs'] = {
                icon = 'finder',
                color = 'magenta',
                filetypes = '.macos',
            },
            ['Fzf'] = {
                icon = 'telescope',
                color = 'red',
                filetypes = 'fzf',
            },
            ['Hushlogin'] = {
                icon = 'mute',
                color = 'black',
                filetypes = 'hushlogin',
            },
            ['MyCnf'] = {
                icon = 'database',
                color = 'blue',
                filetypes = 'my.cnf',
            },
            ['README'] = {
                icon = 'documentation',
                color = 'red',
                filetypes = 'README.md',
            },
            ['Starship'] = {
                icon = 'rocket',
                color = 'magenta',
                filetypes = 'starship.toml',
            },
            ['NvmRc'] = {
                icon = 'npm',
                color = 'blue',
                filetypes = '.nvmrc',
            },
            ['Lockfile'] = {
                icon = 'lockfile',
                color = 'white',
                filetypes = '.lock',
            },
            ['BitbucketPipeline'] = {
                icon = 'bitbucket',
                color = 'bright_blue',
                filetype = 'bitbucket-pipelines.yml',
            },
            ['Composer'] = {
                icon = 'composer',
                color = 'yellow',
                filetype = 'composer.json',
            },
        },
    },
}
