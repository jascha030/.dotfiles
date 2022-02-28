local utils = require 'cokeline.utils'

local colors = {
  errors = { fg = utils.get_hex('DiagnosticError', 'fg') },
  warnings = { fg = utils.get_hex('DiagnosticWarn', 'fg') },
}

local diagnostics =  {
  text = function(buffer)
    return
      (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
      or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
      or ''
  end,

  hl = {
    fg = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and colors.errors.fg)
        or (buffer.diagnostics.warnings ~= 0 and colors.warnings.fg)
        or nil
      end,
  },
  truncation = { priority = 1 },
}

require'cokeline'.setup({
  show_if_buffers_are_at_least = 2,

  buffers = {
    new_buffers_position = 'next',
  },

  default_hl = {
    focused = {
      fg = utils.get_hex('Normal', 'fg'),
      bg = utils.get_hex('Normal', 'bg')
    },
    unfocused = {
      fg = utils.get_hex('Comment', 'fg'),
      bg = utils.get_hex('ColorColumn', 'bg'),
    },
  },

  diagnostics = diagnostics
})

