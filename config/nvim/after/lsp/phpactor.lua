---@diagnostic disable: missing-fields
return Jascha030.lsp.config_extend({
    root_markers = {
        '.git',
        'composer.json',
        'wp-config-sample.php',
        'wp-config.php',
    },
    single_file_support = true,
})
