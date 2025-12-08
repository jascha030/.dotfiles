# ⚡ Neovim Configuration

<div align="center">
  <img src="https://github.com/jascha030/.dotfiles/blob/main/img/nvim-header.png?raw=true" alt="Neovim Header" width="100%" />
</div>

## 📖 Overview

A highly customized, performance-oriented Neovim configuration built completely in **Lua** (with a sprinkle of **Fennel**). It aims to provide a modern IDE-like experience without the bloat, focusing on aesthetics, speed, and ergonomics.

> **Philosophy:** "VS Code features, Vim speed."

## ✨ Key Features

- **🚀 Plugin Management**: Powered by [lazy.nvim](https://github.com/folke/lazy.nvim) for blazing fast startup times.
- **🧠 LSP**: Native `vim.lsp` configuration enhanced with [mason.nvim](https://github.com/mason-org/mason.nvim) to easily install servers, linters, and formatters.
- **🔮 Completion**: Ultra-fast completion using [blink.cmp](https://github.com/saghen/blink.cmp) and snippet support via [LuaSnip](https://github.com/L3MON4D3/LuaSnip).
- **🌲 File Explorer**: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) for visual file management.
- **🔭 Fuzzy Finding**: [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for finding files, grep, and more.
- **🎨 Theme**: Custom [nitepal.nvim](https://github.com/jascha030/nitepal.nvim) colorscheme (Work In Progress).
- **🐘 PHP Support**: Specialized setup for PHP development (DAP, PHPActor, Code Sniffer).

## 📂 File Structure

The configuration follows a modular structure for easy maintenance:

```text
config/nvim/
├── init.lua              # Entry point (bootstraps lazy.nvim)
├── flsproject.fnl        # Fennel project configuration
├── lua/
│   ├── jascha030/        # Core configuration module
│   │   ├── core/         # Options, globals
│   │   └── ...
│   └── plugins/          # Plugin definitions (Lazy.nvim specs)
│       ├── lsp.lua       # LSP & Mason setup
│       ├── completion.lua# Autocompletion
│       └── ...
└── after/                # Filetype specific settings
```

## ⌨️ Keybindings

The **Leader Key** is set to `<Space>`.

| Mode | Key | Action |
| :--- | :--- | :--- |
| **Normal** | `<Space>e` | Toggle File Explorer (Neo-tree) |
| **Normal** | `<Space>ff` | Find Files (Telescope) |
| **Normal** | `<Space>fg` | Live Grep (Telescope) |
| **Normal** | `<Space>fb` | Find Buffers |
| **Normal** | `<C-h/j/k/l>` | Window Navigation |

> **Tip:** This config uses `which-key.nvim`. Press `<Space>` and wait to see a popup with all available keybindings!

## 🛠️ Prerequisites

Ensure you have the following installed on your system:

- **Neovim** (>= 0.9.0)
- **Node.js** (required for some LSPs/Mason)
- **Ripgrep** (required for Telescope)
- **fd** (optional, improves file finding)
- **PHP** (if using PHP features)
- **Composer**

## 📦 Installation

This configuration is part of my dotfiles. To install it separately:

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone repo (assuming you just want the nvim config)
# Note: This repo is a full dotfiles repo, so you'd normally link it.
git clone https://github.com/jascha030/.dotfiles.git ~/tmp_dotfiles
mkdir -p ~/.config/nvim
cp -r ~/tmp_dotfiles/config/nvim/* ~/.config/nvim/
```