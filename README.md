<p align="center">
  <img src="https://github.com/jascha030/.dotfiles/blob/main/img/NVIM-PAK.png?raw=true" alt="Dotfiles, not even once.">
</p>

# Jascha030's dotfiles

[My](https://github.com/jascha030) personal Dotfiles repository, a collection of configuration files that are used to personalize and configure my development environment and applications.

## Includes but not limited to

- 📝 [Neovim Config](https://github.com/jascha030/.dotfiles/blob/main/config/nvim/README.md) - My daily driver editor with Lua, Fennel, and custom plugins
- 💾 [ZShell (ZSH) Config](https://github.com/jascha030/.dotfiles/blob/main/config/zsh/README.md) - Handcrafted shell with custom prompt and startup screens
- 📦 Package management for MacOS using [Homebrew](https://brew.sh/) - 300+ packages, casks, and VSCode extensions
- 🥄 Automation, hotkeys and custom window management for MacOS using [Hammerspoon](https://www.hammerspoon.org/) - Window management and app switching
- 💽 Configs for multiple terminal emulators
  - ⚡ WezTerm - GPU-accelerated with custom themes and keybindings
  - 👻 Ghostty - Modern terminal with holographic icons and custom shaders
- 🪄 Many scripts for making my life easier, scaring my colleagues and making my friends believe I am a _Hackerman_.
- 💩 Absolutely not a single tool for managing symlinks like [stow](https://www.gnu.org/software/stow/), instead I just `ln -s` by hand because I f-d up once, and now I have trust issues.

## What makes this setup special?

- **Custom color schemes**: [nitepal.nvim](https://github.com/jascha030/nitepal.nvim) - My ongoing colorscheme project
- **Terminal aesthetics**: Carefully crafted themes, fonts, and animations
- **Development workflow**: PHP, JavaScript, Lua, and more with LSP, DAP, and testing
- **MacOS integration**: System defaults, automation, and productivity enhancements
- **Security**: Encrypted secrets management with git-secret
- **Version management**: Multiple PHP, Node, and Python versions with rtx

## Quick setup (if you're brave enough)

```bash
# Clone the repo
git clone https://github.com/jascha030/.dotfiles.git ~/.dotfiles

# Install packages
brew bundle --file ~/.dotfiles/Brewfile

# Apply macOS defaults (careful, this changes system settings!)
~/.dotfiles/.macos

# Symlink configs (or do it manually like I do)
# ... your preferred method here
```

*Disclaimer: These configs are highly personalized. Use at your own risk, and don't blame me if your setup becomes too awesome.*
