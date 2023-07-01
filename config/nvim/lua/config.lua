return {
    colorscheme = 'nitepal',
    options = {
        opt = {
            expandtab = true,
            smartindent = true,
            number = true,
            cursorline = true,
            modifiable = true,
            termguicolors = true,
            incsearch = true,
            rnu = true,
            scrolloff = 5,
            showtabline = 2,
            tabstop = 4,
            shiftwidth = 4,
            updatetime = 1000,
            mouse = 'nvi',
            colorcolumn = '120',
            backspace = 'indent,eol,start',
            fileencoding = 'utf-8',
            fillchars = 'eob: ,msgsep:‾',
            signcolumn = 'yes',
            shell = '/bin/zsh',
            foldmethod = 'expr',
            foldexpr = 'nvim_treesitter#foldexpr()',
        },
        g = {
            loaded_netrw = 1,
            loaded_netrwPlugin = 1,
            gitblame_display_virtual_text = 0,
        },
    },
    keymaps = {
        ['n'] = {
            ['ff'] = { ':lua require("telescope.builtin").find_files()<CR>' },
            ['FF'] = { ':lua require("telescope").extensions.file_browser.file_browser()<CR>' },
            ['<C-p>'] = { ':lua require("telescope.builtin").git_files()<CR>' },
            ['fg'] = { ':lua require("telescope.builtin").live_grep()<CR>' },
            ['<C-f>'] = { ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>' },
            ['<C-l>'] = { ':lua vim.lsp.buf.format()<CR>' },
            ['<S-Tab>'] = { '<Plug>(cokeline-focus-next)', { silent = true } },
            ['<C-w><C-c>'] = { '<cmd>close<CR>' },
            ['<C-n>'] = { '<cmd>NeoTreeFocusToggle<CR>' },
            ['N'] = { '<cmd>NeoTreeFocus<CR>' },
            ['ss'] = { '<cmd>Telescope<CR>' },
            ['TT'] = { '<cmd>TroubleToggle<CR>' },
            ['<Tab><Tab>'] = { '<cmd>HopWord<CR>' },
            ['sR'] = { '<cmd>source $MYVIMRC<CR>', { noremap = true, silent = true } },
            ['<C-t>'] = { '<cmd>[!]<CR>' },
            ['m'] = { '<cmd>Mason<CR>' },
            ['<C-_>'] = { '<cmd>CommentToggle<CR>' },
            ['<leader>CP'] = { '<cmd>PickColor<CR>' },
            -- TreeSitter
            ['<leader>tc'] = { '<cmd>TSHighlightCapturesUnderCursor<CR>' },
            ['<leader>p'] = { '<cmd>TSPlaygroundToggle<CR>' },
        },
        ['v'] = {
            ['<C-c>'] = { ':OSCYankVisual<CR>' },
            ['<C-_>'] = { ":'<,'>CommentToggle<CR>" },
        },
        ['t'] = {
            ['<M-[>'] = { '<Esc>' },
            ['<C-v><Esc>'] = { '<Esc>' },
        },
        ['i'] = {},
    },
    devicons = {
        default_icon = '',
        icons = require('core.icons').icons,
        overrides = {
            ['Alias'] = { icon = 'alias', filetypes = 'aliases' },
            ['Autols'] = { icon = 'fileinfo', filetypes = 'auto-ls' },
            ['ZshOverrides'] = { icon = 'alias', filetypes = 'overrides' },
            ['Ignore'] = {
                icon = 'ignore',
                filetypes = {
                    ['Git'] = '.gitignore',
                    ['GlobalGit'] = 'gitignore_global',
                    ['Stylua'] = '.styluaignore',
                },
            },
            ['GitConfig'] = { icon = 'git', filetypes = { ['Default'] = '.gitconfig', ['Dotfile'] = 'gitconfig' } },
            ['EditorConfig'] = { icon = 'editor', filetypes = '.editorconfig' }, ['Zshrc'] = { icon = 'term', filetypes = '.zshrc' },
            ['Antigenrc'] = { icon = 'term', filetypes = '.antigenrc' },
            ['Zshenv'] = { icon = 'term', filetypes = '.zshenv' },
            ['Init'] = { icon = 'init', filetypes = 'init' },
            ['InitLua'] = { icon = 'init', filetypes = 'init.lua' },
            ['MacOs'] = { icon = 'finder', filetypes = '.macos' },
            ['Fzf'] = { icon = 'telescope', filetypes = 'fzf' },
            ['Hushlogin'] = { icon = 'mute', filetypes = 'hushlogin' },
            ['MyCnf'] = { icon = 'database', filetypes = 'my.cnf' },
            ['README'] = { icon = 'documentation', filetypes = 'README.md' },
            ['Starship'] = { icon = 'rocket', filetypes = 'starship.toml' },
            ['NvmRc'] = { icon = 'npm', filetypes = '.nvmrc' },
            ['Lockfile'] = { icon = 'lockfile', filetypes = '.lock' },
            ['BitbucketPipeline'] = { icon = 'bitbucket', filetypes = 'bitbucket-pipelines.yml' },
            ['Composer'] = { icon = 'composer', filetypes = 'composer.json' },
            ['PluginsSpec'] = { icon = 'list', filetypes = 'plugins-spec' },
            ['Prompt'] = { icon = 'rocket', filetypes = 'prompt' },
            ['Neon'] = { icon = 'nmode', filetypes = 'neon' },
            ['DistFile'] = { icon = 'package', filetypes = '.dist' }
        },
    },
    lsp = {},
}
