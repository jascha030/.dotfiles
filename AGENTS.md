# Repo Notes

## Structure
- macOS dotfiles repo, not an app/library. Most changes target configs symlinked into `~` or `~/.config`.
- Main entrypoints: `config/zsh/.zshenv`, `config/zsh/.zshrc`, `config/nvim/init.lua`, `config/wezterm/wezterm.lua`, `config/ghostty/config`, `hammerspoon/init.lua`, `.macos`, `Brewfile`.
- Neovim plugins: `config/nvim/lua/plugins/*.lua`; versions pinned in `config/nvim/lazy-lock.json`.
- Hammerspoon logic: `hammerspoon/jascha030/*.lua`; `hammerspoon/Spoons/` is ignored/vendor space.
- `bin/` scripts are on `$PATH`. `bin/generate-dotfiles-links` snapshots existing `~`/`~/.config` symlinks into `restore-dotfile-symlinks.sh`.
- Repo-local OpenCode config: `config/opencode/opencode.json`; extra OpenCode instructions: `config/opencode/AGENTS.md`.

## Assumptions
- Many scripts assume the repo path is `~/.dotfiles` via `$DOTFILES`.
- `config/zsh/.zshenv` bootstraps `~/.env` from repo `.env` and symlinks `~/.config/zsh` to `config/zsh` if missing.
- Do not introduce `stow` or other symlink managers. This repo intentionally uses manual `ln -s`.

## Editing
- `.editorconfig`: 2 spaces default; 4 spaces for `*.lua`, `*.php`, `*.xml`, `composer.json`, and `phpactor.json`.
- Lua formatting is defined by `stylua.toml`: 4 spaces, 120 columns, prefer single quotes, always include call parentheses.
- `.luarc.json` disables Lua formatting — do not rely on Lua LSP formatting.
- Zsh startup precompiles some sources to `*.zwc`; edit the source files under `config/zsh/`, not compiled artifacts.

## Verify
- Dependency sync: `brew bundle --file Brewfile`
- Lua formatting: run `stylua` on touched Lua paths from repo root; `.styluaignore` excludes `hammerspoon/Spoons/*`.
- There is no CI, task runner, or automated test suite.
- Zsh changes: start a new login shell or `source ~/.zshrc`.
- Neovim changes: launch `nvim`; `config/nvim/init.lua` bootstraps `lazy.nvim`, and `lua/plugins/lsp.lua` auto-installs Mason tools.
- Hammerspoon changes: `ReloadConfiguration` is loaded, so edits should auto-reload.
- Do not run `.macos` unless the user explicitly wants macOS defaults changed; it uses `sudo` and writes system settings.

## Sensitive Files
- `.ssh/`, `gitconfig.secret`, `*.secret`, `.gitsecret/` are sensitive. The repo `.env` is non-sensitive bootstrap config; it sources `~/env.local` for secrets.
