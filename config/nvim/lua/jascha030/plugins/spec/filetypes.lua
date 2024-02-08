local M = {
    'nathom/filetype.nvim',
    cond = false,
    opts = {
        overrides = {
            extensions = {
                ['neon'] = 'yaml',
                ['neon.dist'] = 'yaml',
                ['tape'] = 'tape',
                ['ejs.t'] = 'embedded_template',
                ['cnf'] = 'dosini',
                ['kdl'] = 'kdl',
                ['Brewfile'] = 'ruby',
                ['gitignore_global'] = 'gitignore',
                ['*.*ignore'] = 'gitignore',
                ['gitattributes'] = 'gitattributes',
                ['gitconfig'] = 'gitconfig',
                ['*.md'] = 'markdown',
                ['*.MD'] = 'markdown',
                ['Deployfile'] = 'json',
                ['*.json.dist'] = 'json',
                ['*.svg'] = 'xml',
                ['*.xml.dist'] = 'xml',
                ['*.nginx'] = 'nginx',
                ['*/.config/valet/Nginx/*'] = 'nginx',
                ['*.antigenrc'] = 'zsh',
                ['.zsh*'] = 'zsh',
            },
        },
    },
}

return M
