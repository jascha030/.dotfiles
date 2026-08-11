#!/usr/bin/env nu
# Nushell environment configuration.
# Loaded before config.nu.

# ── XDG directories ───────────────────────────────────────────────────────────
$env.XDG_CONFIG_HOME = ($env.HOME | path join '.config')
$env.XDG_CACHE_HOME  = ($env.HOME | path join '.cache')
$env.XDG_DATA_HOME   = ($env.HOME | path join '.local' 'share')
$env.XDG_STATE_HOME  = ($env.HOME | path join '.local' 'state')

# ── Dotfiles / project directories ────────────────────────────────────────────
$env.DOTFILES  = ($env.HOME | path join '.dotfiles')
$env.DEV_HOME  = ($env.HOME | path join '.development')
$env.DEV       = ($env.DEV_HOME | path join 'Projects')
$env.DOWNLOADS = ($env.HOME | path join 'Downloads')

$env.DOT_DATA_DIR = ($env.XDG_CONFIG_HOME | path join 'datafiles')

# ── Editor / pager ────────────────────────────────────────────────────────────
$env.EDITOR   = 'nvim'
$env.MANPAGER = 'nvim +Man!'

# ── Tool preferences ──────────────────────────────────────────────────────────
$env.LS_OVERRIDE  = 'eza'
$env.CAT_OVERRIDE = 'madcat'
$env.COMPOSER_DEFAULT_VENDOR = 'jascha030'
$env.NPM_CHECK_INSTALLER = 'pnpm npm-check -u'
$env.TOOLCHAINS = 'swift'

$env.LAZYGIT_CONFIG = ($env.XDG_CONFIG_HOME | path join 'lazygit')
$env.PNPM_HOME      = ($env.HOME | path join 'Library' 'pnpm')
$env.RUSTC_WRAPPER  = ($env.HOME | path join '.cargo' 'bin' 'sccache')

# ── PHP / Valet logs ──────────────────────────────────────────────────────────
$env.FPM_LOG_DIR = ($env.XDG_CONFIG_HOME | path join 'valet' 'Log')
$env.FPM_LOG     = ($env.FPM_LOG_DIR | path join 'php-fpm.log')

# ── Compiler flags ────────────────────────────────────────────────────────────
$env.PKG_CONFIG_PATH = '/usr/local/opt/openssl@1.1/lib/pkgconfig'
$env.LDFLAGS  = '-L/usr/local/opt/ncurses/lib -L/opt/homebrew/opt/ncurses/lib -L/opt/homebrew/opt/pcre2/lib'
$env.CPPFLAGS = '-I/usr/local/opt/ncurses/include -I/opt/homebrew/opt/ncurses/include -I/opt/homebrew/opt/pcre2/include'

# ── Module search paths ───────────────────────────────────────────────────────
$env.NU_LIB_DIRS = [
  ($nu.default-config-dir | path join 'lib')
  ($nu.default-config-dir | path join 'scripts')
]

# ── PATH conversions ──────────────────────────────────────────────────────────
$env.ENV_CONVERSIONS = {
  'PATH': {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  'Path': {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# ── PATH assembly ─────────────────────────────────────────────────────────────
let brew_home = '/opt/homebrew/opt'

let dot_path_var = [
  ($brew_home | path join 'ncurses' 'bin')
  ($brew_home | path join 'gnu-sed' 'libexec' 'gnubin')
  ($brew_home | path join 'openjdk' 'bin')
  ($brew_home | path join 'openssl@1.1' 'bin')
  ($env.XDG_CONFIG_HOME | path join 'bash' 'bin')
  ($env.XDG_CONFIG_HOME | path join 'zsh' 'bin')
  ($env.HOME | path join 'bin')
  ($env.HOME | path join 'tools')
  ($env.HOME | path join '.gem' 'ruby' '2.6.0' 'bin')
  ($env.HOME | path join '.cargo' 'bin')
  ($env.HOME | path join 'go' 'bin')
  ($env.HOME | path join '.local' 'share' 'nvim' 'mason' 'bin')
  ($env.HOME | path join '.local' 'share' 'mise' 'shims')
  ($env.HOME | path join '.local' 'bin')
  ($env.HOME | path join '.composer' 'vendor' 'bin')
  $env.PNPM_HOME
]

$env.PATH = (
  $dot_path_var
  | where { |it| ($it | path expand | path type) == 'dir' }
  | append ($env.PATH? | default [] | split row (char esep) | path expand -n)
  | uniq
)
