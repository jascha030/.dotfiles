# 🐚 Zsh Configuration

<div align="center">
  <img src="https://github.com/jascha030/.dotfiles/blob/main/img/ZSH_Prompt.png?raw=true" alt="ZSH Prompt" width="100%">
</div>

## 📖 Overview

A purely handcrafted Zsh configuration. No frameworks (oh-my-zsh, prezto, etc.), just raw shell scripting for maximum performance and control. It features a custom prompt, intelligent aliases, and a modular structure.

## ✨ Features

- **⚡ Zero Frameworks**: Built from scratch for speed.
- **🎨 Custom Prompt**: Git-aware, status-indicating, and anxiety-inducing detail.
- **🧠 Intelligent Completion**: Powered by `fzf-tab` and `zsh-completions`.
- **🚀 Fast Startup**: Optimized `path` management and lazy-loading.
- **👾 Intro Screens**: Randomly selected intro animations (because why not?).

## 📂 Structure

```text
config/zsh/
├── .zshrc           # Main entry point (sources init)
├── init             # Core initialization logic
├── aliases          # All shell aliases
├── env              # Environment variables
├── plugins-spec     # Plugin list (custom loader)
├── prompt/          # Custom prompt logic
└── zfunc/           # Autoloaded functions
```

## 🔌 Plugins

Plugins are managed via a custom lightweight function in `plugins-spec`.

- **[fzf-tab](https://github.com/Aloxaf/fzf-tab)**: Replace zsh's default completion selection menu with fzf.
- **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**: Fish-like autosuggestions.
- **[zsh-completions](https://github.com/zsh-users/zsh-completions)**: Additional completion definitions.

## ⌨️ Useful Aliases

| Alias | Command | Description |
| :--- | :--- | :--- |
| `c` | `clear-screen` | Clear terminal |
| `ll`, `l`, `kk` | `ll` | List files (long format) |
| `lg` | `lazygit` | Open LazyGit |
| `n`, `vim` | `nvim` | Open Neovim |
| `rr` | `exec ${SHELL} -l` | Reload shell configuration |
| `valetr` | `valet restart` | Restart Laravel Valet |
| `wpuser:create` | `wp ... user create` | Create WP Admin user |

## 🖼️ Gallery

### Intro Screens
![Terminal Intro](https://github.com/jascha030/.dotfiles/blob/main/img/termintro.gif?raw=true)