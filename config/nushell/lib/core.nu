#!/usr/bin/env nu
# Nushell helper commands.
# Scope 1: simple conditional wrappers and directory helpers.

# ── Filesystem guards ─────────────────────────────────────────────────────────
export def assert_dirs [...dirs: string] {
  for $d in $dirs {
    if not ($d | path exists) {
      mkdir $d
    }
  }
}

export def assert_files [...files: string] {
  for $f in $files {
    if not ($f | path exists) {
      touch $f
    }
  }
}

# ── Pasteboard helpers ────────────────────────────────────────────────────────
export def copy-to-pasteboard [...files: string] {
  if ($files | is-empty) {
    $in | ^pbcopy
  } else {
    ^cat ...$files | ^pbcopy
  }
}

export def copy-dir-path [] {
  $env.PWD | ^pbcopy
}

# ── macOS appearance ──────────────────────────────────────────────────────────
export def is_dark []: nothing -> bool {
  (^defaults read -globalDomain AppleInterfaceStyle 2>/dev/null | str trim) == 'Dark'
}

# ── Listing: pick the best available lister ───────────────────────────────────
export def --wrapped ll [...args: string] {
  # Prefer lsd: the cargo build of eza returns no output when Nushell is not
  # connected to a TTY, so lsd is the safer default in this shell.
  if (not (which lsd | is-empty)) {
    ^lsd -Ahl --group-directories-first --color=always ...$args
  } else if (not (which eza | is-empty)) {
    ^eza -Ahl --colour=always --group-directories-first --icons=always ...$args
  } else {
    ^ls -Ahl --color=always ...$args
  }
}

export def --wrapped lll [...args: string] {
  if (which lolcrab | is-empty) {
    error make { msg: 'lolcrab is not installed' }
  }
  ll ...$args | ^lolcrab
}

export def llc [] {
  ls | length
}

# ── Navigation helpers ────────────────────────────────────────────────────────
export def --env root [] {
  let top = (git rev-parse --show-toplevel | str trim)
  cd $top
}

export def --env composerhome [] {
  let home = (composer -g config home | str trim)
  cd $home
}

# ── Git clone shortcuts ───────────────────────────────────────────────────────
export def gcl [shortcut: string, ...args: string] {
  let repos = {
    sb-starter: 'git@bitbucket.org:socialbrothers/wordpress-starter-theme.git'
    wp: 'git@github.com:wordpress/wordpress'
  }
  let repo = ($repos | get --optional $shortcut | default $shortcut)
  git clone $repo ...$args
}

# ── Xdebug toggle ─────────────────────────────────────────────────────────────
export def --env xdbs [cmd: string] {
  match $cmd {
    'start' => { load-env { XDEBUG_MODE: debug, XDEBUG_SESSION: 1 } }
    'stop' => { hide-env XDEBUG_MODE; hide-env XDEBUG_SESSION }
    _ => { error make { msg: $'Invalid xdbs command: ($cmd). Use start|stop.' } }
  }
}

# ── Terminal / macOS ──────────────────────────────────────────────────────────
export def ghosttydocs [] {
  ghostty +show-config --default --docs | ^nvim +Man!
}

export def tm-auto [] {
  sudo tmutil startbackup --auto
  tmutil status
}

export def scrsvr [] {
  ^open -a ScreenSaverEngine
}

export def brewup [] {
  brew update
  brew outdated
  brew upgrade
  brew cleanup
  brew doctor
}

# ── Diagnostics ───────────────────────────────────────────────────────────────
export def check:italics [] { print "\e[3mitalic\e[23m" }
export def check:bold [] { print "\e[1mbold\e[22m" }

export def check:colors [] {
  curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
}

# ── Path introspection ────────────────────────────────────────────────────────
export def ls-path [] {
  $env.PATH | split row (char esep)
}

export def ls-fpath [] {
  $env.NU_LIB_DIRS? | default []
}

# ── Dotfile helpers ───────────────────────────────────────────────────────────
export def prompt:gemini [] {
  open ($env.HOME | path join '.dotfiles' 'PROMPT.md') | ^pbcopy
}

export def gh:codeowners [] {
  mkdir .github/
  '* @jascha030' | save .github/CODEOWNERS
}

export def gen:codeowners [] {
  mkdir .github/
  '* @jascha030' | save --append .github/CODEOWNERS
}
