local M = {
    'yamatsum/nvim-nonicons',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    event = { 'VeryLazy' }
}

function M.config(_, opts)
    require('nvim-nonicons').setup(opts)

    require('jascha030.config.devicons').setup(require('jascha030').options.devicons)
end

return M
