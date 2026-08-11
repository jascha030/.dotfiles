#!/usr/bin/env nu
# Nushell configuration file.
# Scope 1: minimal viable daily driver.

# Load helper commands.
use lib/core.nu *

# Load aliases.
source aliases.nu

$env.config = {
  show_banner: false

  ls: {
    use_ls_colors: true
    clickable_links: true
  }

  rm: {
    always_trash: false
  }

  table: {
    mode: rounded
    index_mode: always
    show_empty: true
    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
      truncating_suffix: '...'
    }
  }

  history: {
    max_size: 100000
    sync_on_enter: true
    file_format: plaintext
    isolation: false
    ignore_space_prefixed: true
  }

  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: prefix
    external: {
      enable: true
      max_results: 100
      completer: null
    }
  }

  filesize: {
    unit: metric
    show_unit: true
    precision: 1
  }

  cursor_shape: {
    emacs: inherit
    vi_insert: inherit
    vi_normal: inherit
  }

  use_ansi_coloring: auto
  edit_mode: emacs
  shell_integration: {
    osc2: true
    osc7: true
    osc8: true
    osc9_9: false
    osc133: true
    osc633: true
    reset_application_mode: true
  }

  bracketed_paste: true
  render_right_prompt_on_last_line: false
  float_precision: 2
  footer_mode: 25
}
