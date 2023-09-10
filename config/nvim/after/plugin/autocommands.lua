local vim = vim
local api = vim.api

local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup ' .. group_name)
        api.nvim_command('autocmd!')

        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
            api.nvim_command(command)
        end

        api.nvim_command('augroup END')
    end
end

nvim_create_augroups({ open_folds = { { 'BufReadPost,FileReadPost', '*', 'normal zR' } } })

vim.api.nvim_create_autocmd('BufRead', {
    group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
    pattern = 'Cargo.toml',
    callback = function()
        require('cmp').setup.buffer({
            sources = {
                {
                    name = 'crates',
                },
            },
        })
    end,
})

vim.cmd([[
  augroup _lsp
    autocmd!
    autocmd FileType php setlocal omnifunc=phpactor#Complete
    autocmd BufRead,BufNewFile .zsh* set tabstop=4 | set shiftwidth=4
  augroup end

  augroup _ft
    autocmd!
    autocmd BufReadPost *.neon,*.neon.dist set ft=yaml
    autocmd BufReadPost *.tape set ft=tape
    autocmd BufReadPost *.ejs.t set ft=embedded_template
    autocmd BufReadPost *.cnf set ft=dosini
    autocmd BufReadPost *.kdl set ft=kdl

    autocmd FileType help,lspinfo nnoremap <buffer><silent> q :close<CR>
    autocmd FileType dashboard,toggleterm nnoremap <buffer><silent> q :q<CR>
  augroup end
]])
