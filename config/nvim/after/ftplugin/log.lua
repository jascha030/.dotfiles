vim.opt.wrap = false

if require('jascha030.utils.buffer').is_huge({ bufnr = 0 }) then
    vim.opt.syntax = false
end
