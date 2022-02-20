local utils = require'cokeline.utils'

local diagnostics = {
  colors = {
    errors = { fg = utils.get_hex('DiagnosticError', 'fg') },
    warnings = { fg = utils.get_hex('DiagnosticWarn', 'fg') },
  }
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

  rendering = {
    right_sidebar = {},
  },

  components = {
    {
      text = function(buffer)
        return
          (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
          or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
          or ''
      end,

      hl = {
        fg = function(buffer)
          return
            (buffer.diagnostics.errors ~= 0 and diagnostics.colors.errors.fg)
            or (buffer.diagnostics.warnings ~= 0 and diagnostics.colors.warnings.fg)
            or nil
        end,
      },

      truncation = { priority = 1 },
    },
  },
})

