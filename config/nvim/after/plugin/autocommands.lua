-- Detect filetype on files with no extension after saving the file.
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('FileDetect', {}),
    desc = 'Detect filetype on files with no extension after saving the file',
    callback = function()
        if vim.bo.filetype == '' then
            vim.cmd('filetype detect')
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function(args)
        vim.opt_local.formatoptions:remove('o')

        local ft = vim.bo[args.buf].filetype

        if ft == 'zsh' then
            return
        end

        local lang = vim.treesitter.language.get_lang(ft) or ft

        local ok = vim.treesitter.language.add(lang)

        if not ok then
            local available = vim.g.ts_available or require('nvim-treesitter').get_available()
            vim.g.ts_available = vim.g.ts_available or available

            if vim.tbl_contains(available, lang) then
                require('nvim-treesitter').install(lang)
                ok = vim.treesitter.language.add(lang)
            end
        end

        if ok then
            vim.treesitter.start(args.buf, lang)
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
        end
    end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
    pattern = '*',
    group = vim.api.nvim_create_augroup('_folds', {}),
    desc = 'Open all folds',
    command = 'normal zR',
})

-- Quit Neovim when the snacks explorer is the only remaining window.
vim.api.nvim_create_autocmd('WinEnter', {
    group = vim.api.nvim_create_augroup('ExplorerQuitOnLast', {}),
    desc = 'Quit when explorer is the last window',
    callback = function()
        local pickers = Snacks.picker.get({ source = 'explorer' })
        if #pickers == 0 then
            return
        end

        local snacks_fts = { snacks_picker_list = true, snacks_layout_box = true }
        local wins = vim.api.nvim_list_wins()

        for _, win in ipairs(wins) do
            local cfg = vim.api.nvim_win_get_config(win)
            if cfg.relative == '' then
                local buf = vim.api.nvim_win_get_buf(win)
                local ft = vim.bo[buf].filetype

                if not snacks_fts[ft] then
                    return
                end
            end
        end

        for _, picker in ipairs(pickers) do
            picker:close()
        end

        vim.cmd('qa')
    end,
})

-- I was too lazy to do everything lua hehehehe.
vim.cmd([[
  augroup _ft
    autocmd!
    autocmd BufReadPost *.tape set ft=tape
    autocmd BufReadPost *.ejs.t set ft=embedded_template
    autocmd BufReadPost *.cnf set ft=dosini
    autocmd BufReadPost *.kdl set ft=kdl
    autocmd BufReadPost *Brewfile set ft=ruby
    autocmd BufReadPost *.mdc set ft=markdown
    " NUShell
    autocmd BufRead,BufNewFile *.nu set ft=nu
    " Git
    autocmd BufRead,BufNewFile gitignore_global,*.*ignore set ft=gitignore
    autocmd BufRead,BufNewFile *.gitattributes set ft=gitattributes
    autocmd BufRead,BufNewFile *.gitconfig,gitconfig set ft=gitconfig
    " JSON
    autocmd BufRead,BufNewFile Deployfile set ft=json
    autocmd BufRead,BufNewFile *.json.dist set ft=json
    " XML
    autocmd BufNewFile,BufRead *.svg set ft=xml
    autocmd BufNewFile,BufRead *.xml.dist set ft=xml
    " Nginx
    autocmd BufRead,BufNewFile *.nginx set ft=nginx
    autocmd BufRead,BufNewFile */.config/valet/Nginx/* set ft=nginx
    " ZSH
    autocmd BufRead,BufNewFile *.antigenrc setfiletype zsh
    autocmd BufRead,BufNewFile .zsh* setfiletype zsh
    " Neon
    autocmd BufRead,BufNewFile *.neon,*.neon.dist set ft=neon
    " INI
    autocmd BufRead,BufNewFile *.ini* set ft=ini
    " PHP 
    autocmd BufRead,BufNewFile composer.json,.phpactor.json set tabstop=4 | set shiftwidth=4 | set expandtab | set softtabstop=4
    autocmd BufRead,BufNewFile composer.lock set ft=json
    " Ghostty
    autocmd BufRead,BufNewFile **/.*/**/ghostty/config,**/ghostty/themes/* set ft=ghostty
  augroup end
]])
