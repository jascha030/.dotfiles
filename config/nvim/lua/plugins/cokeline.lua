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

local default_hl = {
  fg = function(buffer)
    return
      buffer.is_focussed
      and utils.get_hex('Normal', 'fg')
      or utils.get_hex('Comment', 'fg')
  end,
  bg = function(buffer)
    return
      buffer.is_focussed
      and utils.get_hex('Normal', 'bg')
      or utils.get_hex('ColorColumn', 'bg')
  end,
}

require'cokeline'.setup({
  show_if_buffers_are_at_least = 2,

  buffers = {
    new_buffers_position = 'next',
  },

  default_hl = default_hl,

  components = {
    diagnostics = diagnostics
  },
})

