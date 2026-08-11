#!/usr/bin/env nu
# Nushell aliases.
# Scope 1: only simple command aliases. Compound commands (semicolons, pipes,
# sub-expressions) live in lib/core.nu as defs to avoid executing them at
# parse-time.

# ── Navigation ────────────────────────────────────────────────────────────────
alias h = cd ~
alias config = cd $env.XDG_CONFIG_HOME
alias cf = config
alias dev = cd $env.DEV
alias df = cd $env.DOTFILES

# ── Shell lifecycle ───────────────────────────────────────────────────────────
alias rr = exec $env.SHELL -l
alias x = exit
alias c = clear

# ── Editors / git ─────────────────────────────────────────────────────────────
alias n = nvim
alias lg = lazygit

# ── Listing ───────────────────────────────────────────────────────────────────
alias l = ll
alias kk = ll

# ── macOS / general ───────────────────────────────────────────────────────────
alias o = open .
