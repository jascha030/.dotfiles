<div align="center">

  <img src="https://github.com/jascha030/.dotfiles/blob/main/img/NVIM-PAK.png?raw=true" alt="Dotfiles Logo" width="600" />

  <h1>Jascha030's Dotfiles</h1>

  <p>
    <a href="https://github.com/jascha030/.dotfiles/search?l=lua"><img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" alt="Lua" /></a>
    <a href="https://github.com/jascha030/.dotfiles/search?l=shell"><img src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell" /></a>
    <a href="https://neovim.io/"><img src="https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim" /></a>
    <a href="https://brew.sh/"><img src="https://img.shields.io/badge/Homebrew-FBB040?style=for-the-badge&logo=homebrew&logoColor=white" alt="Homebrew" /></a>
    <a href="https://www.hammerspoon.org/"><img src="https://img.shields.io/badge/Hammerspoon-7C7C7C?style=for-the-badge&logo=lua&logoColor=white" alt="Hammerspoon" /></a>
  </p>

  <p><strong>"Dotfiles, not even once."</strong></p>

  <p>
    My personal configuration repository. A manifestation of my refusal to do things the easy way.<br>
    Built for <strong>macOS</strong>, powered by <strong>Lua</strong>, and obsessed with <strong>aesthetic</strong>.
  </p>

</div>

---

## 📸 Showcase

<div align="center">
  <img src="https://github.com/jascha030/.dotfiles/blob/main/img/term.gif?raw=true" alt="Terminal Demo" width="100%" />
</div>

<br>

| Neovim PHP | Terminal Intro |
|:---:|:---:|
| <img src="https://github.com/jascha030/.dotfiles/blob/main/img/nvim_php.png?raw=true" alt="Neovim PHP" /> | <img src="https://github.com/jascha030/.dotfiles/blob/main/img/termintro.gif?raw=true" alt="Terminal Intro" /> |

---

## 🧰 The Arsenal

### 📝 [Neovim Config](./config/nvim/README.md)
My pride and joy. A fully Lua-configured editor that makes VS Code look like Notepad.
- **Plugin Manager**: `lazy.nvim` (30+ plugins)
- **LSP**: Native `vim.lsp` with `mason.nvim`
- **Theme**: Custom `nitepal.nvim`

### 💾 [ZShell (ZSH) Config](./config/zsh/README.md)
Handcrafted shell experience. No frameworks, just pure obsession.
- **Prompt**: Custom git status, icons, and anxiety-inducing detail.
- **Startup**: Alternating intro screens to distract me from work.

### 🔨 [Hammerspoon](./hammerspoon/README.md)
Lua scripting for macOS.
- **Window Management**: Zero-latency tiling.
- **Quake Mode**: Drop-down terminal toggle for WezTerm/Ghostty (`Cmd` + `Cmd` in theory, actually mapped to `Ctrl+Alt+Cmd+T`).

### 🖥️ Terminal Emulators
- **[WezTerm](./config/wezterm/README.md)**: GPU-accelerated, Lua-configured.
- **[Ghostty](./config/ghostty/README.md)**: The new kid on the block. Custom shaders and holographic icons.

---

## 🏗️ Philosophy

> "I absolutely do not use a single tool for managing symlinks like `stow`, instead I just `ln -s` by hand because I f-d up once, and now I have trust issues."

This repository is a collection of my personal settings. It is designed to be:
1.  **Portable-ish**: It works on my machine.
2.  **Fast**: Bloat is the enemy (except for the 50 neovim plugins).
3.  **Beautiful**: If it doesn't look good, I can't code in it.

## 🚀 Quick(ish) Setup

If you are brave enough to try this:

```bash
# 1. Clone the repo
git clone https://github.com/jascha030/.dotfiles.git ~/.dotfiles

# 2. Install dependencies (grab a coffee ☕)
brew bundle --file ~/.dotfiles/Brewfile

# 3. Apply macOS defaults (⚠️ This changes system settings!)
~/.dotfiles/.macos

# 4. Link files (The manual way, as god intended)
# Example: Linking Neovim
ln -s ~/.dotfiles/config/nvim ~/.config/nvim

# Example: Linking Zsh
ln -s ~/.dotfiles/config/zsh/.zshrc ~/.zshrc
```

## 📂 Directory Structure

- **`/config`**: The meat. XDG-compliant config files (nvim, zsh, wezterm, etc.).
- **`/bin`**: Custom scripts added to `$PATH`.
- **`/hammerspoon`**: macOS automation scripts.
- **`.macos`**: Shell script to set sensible macOS defaults.
- **`Brewfile`**: List of all installed system packages.

---

<div align="center">
  <sub>Configured with ❤️ and too much ☕ by <a href="https://github.com/jascha030">jascha030</a></sub>
</div>
