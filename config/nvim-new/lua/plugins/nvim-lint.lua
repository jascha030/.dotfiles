local M = {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        linters_by_ft = {
            php = { 'phpstan' },
        },
    },
}

function M.config(_, opts)
    local lint = require('lint')

    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
            lint.try_lint()
        end,
    })
end

return M
