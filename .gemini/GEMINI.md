# GEMINI.MD: AI Collaboration Guide

This document provides essential context for AI models interacting with this project. Adhering to these guidelines will ensure consistency and maintain code quality.

## 1. Project Overview & Purpose

*   **Primary Goal:** This is a comprehensive personal configuration repository ("dotfiles") for macOS. It manages the configuration for the user's shell, editor, terminal, and window management environment. It is designed to be aesthetically pleasing ("obsessed with aesthetic"), highly customized, and portable across the user's machines.
*   **Business Domain:** Personal Development Environment (PDE) / System Administration / Developer Productivity.
*   **Key Philosophy:**
    *   **Manual Control:** The user explicitly avoids automated symlink managers like `stow` in favor of manual `ln -s` commands to maintain absolute control and avoid "trust issues."
    *   **Lua-First:** Heavily relies on Lua for configuration (Neovim, WezTerm, Hammerspoon).
    *   **Performance:** Prioritizes speed and "bloat" reduction (with a stated exception for Neovim plugins).

## 2. Core Technologies & Stack

*   **Languages:**
    *   **Lua:** Primary configuration language for Neovim, WezTerm, and Hammerspoon.
    *   **Shell (Zsh):** Primary shell scripting language.
    *   **Fennel:** Used in specific Neovim configurations (`flsproject.fnl`).
    *   **PHP:** Supported environment (referenced in `php-cs-fixer`, `phpactor`).
*   **Frameworks & Runtimes:**
    *   **Neovim Runtime:** `vim.cmd`, `vim.api`, etc.
    *   **Hammerspoon:** macOS automation engine.
*   **Tools & Utilities:**
    *   **Neovim:** The core text editor.
    *   **WezTerm / Ghostty:** Terminal emulators.
    *   **Homebrew:** System package manager.
    *   **Zsh:** The interactive shell.
    *   **Lazy.nvim:** Neovim plugin manager.
*   **Package Manager(s):**
    *   `Homebrew` (via `Brewfile`) for system packages.
    *   `Lazy.nvim` for Neovim plugins.
    *   `Mason.nvim` for LSP servers and linters.

## 3. Architectural Patterns

*   **Overall Architecture:** Centralized Configuration Repository. The repository mimics the structure of the home directory (or XDG config directory) and uses symbolic links to map files to their actual system locations.
*   **Directory Structure Philosophy:**
    *   `/config`: Contains XDG-compliant configuration directories (e.g., `nvim`, `zsh`, `wezterm`). This is the core of the repo.
    *   `/bin`: Custom executable scripts added to the `$PATH`.
    *   `/hammerspoon`: macOS automation scripts.
    *   `/.macos`: Shell script for setting macOS system defaults.
    *   `/Brewfile`: Defines all system dependencies.
    *   `/git`, `/.ssh`, `/.github`: Specific tool configurations.

## 4. Coding Conventions & Style Guide

*   **Formatting:**
    *   Defined in `.editorconfig`.
    *   **General:** 2 spaces indentation, LF line endings, `charset = utf-8`.
    *   **Lua, PHP, JSON, XML:** **4 spaces** indentation (Overrides the general rule).
*   **Naming Conventions:**
    *   **Lua Files:** snake_case (e.g., `init.lua`, `fonts.lua`, `hotkey.lua`).
    *   **Shell Scripts:** kebab-case or short lowercase (e.g., `nvim-dark-mode`, `fixdb`).
    *   **Functions/Variables:** Follows language idioms (snake_case for Lua/Python, camelCase/snake_case for Shell depending on context).
*   **Lua Style (Neovim):**
    *   Modular configuration: `require('jascha030.globals')`.
    *   Uses `vim.g.mapleader = ' '`.
    *   Prefers `lazy.nvim` specs for plugins.
    *   Use `-- stylua: ignore` comments for ASCII art or specific blocks.
*   **Shell Style (Zsh):**
    *   Shebang: `#!/usr/bin/env zsh`.
    *   Directives: Uses `shellcheck` comments (e.g., `# shellcheck disable=...`).
    *   Modularization: Breaks config into `aliases`, `init`, `env`, etc.

## 5. Key Files & Entrypoints

*   **Main Entrypoint(s):**
    *   **Zsh:** `config/zsh/.zshrc` (sources `config/zsh/init`).
    *   **Neovim:** `config/nvim/init.lua` (bootstraps `jascha030` module).
    *   **Hammerspoon:** `hammerspoon/init.lua`.
*   **Configuration:**
    *   `Brewfile`: The source of truth for installed software.
    *   `.macos`: System preferences automation.
    *   `.editorconfig`: Code style definitions.
*   **CI/CD Pipeline:** None detected (`.github/workflows` is present but empty).

## 6. Development & Testing Workflow

*   **Local Development Environment:**
    1.  Clone repository to `~/.dotfiles`.
    2.  Install dependencies via `brew bundle --file ~/.dotfiles/Brewfile`.
    3.  Run `.macos` script for system defaults.
    4.  **Manually** symlink configurations (e.g., `ln -s ~/.dotfiles/config/nvim ~/.config/nvim`).
*   **Testing:**
    *   There is no automated test suite.
    *   Testing is manual: Apply changes, reload shell (`source ~/.zshrc`) or restart Neovim, and verify behavior.
*   **Dependency Management:**
    *   Add system tools to `Brewfile`.
    *   Add Neovim plugins via `lua/plugins/*.lua` (Lazy.nvim).

## 7. Specific Instructions for AI Collaboration

*   **Symlinking:** **NEVER** suggest using `stow` or automated link managers. Always provide instructions for manual `ln -s` linking if a new config file needs to be installed.
*   **Lua Formatting:** STRICTLY adhere to the **4-space indentation** for Lua files as defined in `.editorconfig`. Do not mix 2-space and 4-space indents.
*   **Neovim Configuration:** When modifying Neovim config, respect the `lazy.nvim` structure. Do not add raw `use` or `Plug` commands; use the `lazy` table syntax.
*   **Shell Scripts:** Ensure scripts are POSIX compliant or explicitly target Zsh (`#!/usr/bin/env zsh`). Use `shellcheck` directives if suppressing warnings is necessary.
*   **Context Awareness:** When editing a file, always check for local imports (e.g., `require(...)` or `source ...`) to understand where variables might be defined.
*   **Safety:** Do not overwrite private keys or secrets. Note that secrets seem to be managed via `git-secret` (presence of `.gitsecret` directory), so be careful not to commit plain-text secrets.
