local M = {
    'yamatsum/nvim-nonicons',
    event = { 'VeryLazy' },
    dependencies = { 'kyazdani42/nvim-web-devicons' },
}

function M.config(_, opts)
    require('nvim-nonicons').setup(opts)
    require('jascha030.config.devicons').setup(require('jascha030').options.devicons)
end

return M
