# GEMINI.MD: AI Collaboration Guide

This document provides essential context for AI models interacting with this project. Adhering to these guidelines will ensure consistency and maintain code quality.

## 1. Project Overview & Purpose

- **Primary Goal:** This project is a collection of personal dotfiles for configuring a development environment on macOS. It automates the setup and customization of shells (Zsh, Bash, Nu), editors (Neovim), terminal emulators (Wezterm, Ghostty), and various development tools. The main purpose is to create a consistent, personalized, and efficient development environment that can be easily replicated.
    
- **Business Domain:** Developer Tools and Environment Management.
    

## 2. Core Technologies & Stack

- **Languages:** Lua, Shell script (Bash, Zsh), PHP, Fennel, Nu Shell.
    
- **Frameworks & Runtimes:** Neovim, Hammerspoon.
    
- **Databases:** None explicitly defined, but `my.cnf` suggests usage of MySQL/MariaDB.
    
- **Key Libraries/Dependencies:** The `Brewfile` indicates a heavy reliance on Homebrew for package management. Key tools installed via Brew include `git`, `php`, `composer`, `node`, `rust`, `go`, various terminal tools, and Neovim plugins.
    
- **Package Manager(s):** Homebrew, Composer.
    

## 3. Architectural Patterns

- **Overall Architecture:** Configuration Management. The project is structured as a centralized repository of configuration files.
    
- **Directory Structure Philosophy:** The structure is organized by application/tool, with a top-level `config` directory containing subdirectories for each application.
    
    - `/config`: Contains all primary configuration files, organized by application (e.g., `nvim`, `zsh`, `wezterm`).
        
    - `/bin`: Contains executable scripts.
        
    - `/git`: Contains git-related configuration files.
        
    - `/hammerspoon`: Contains configuration for the Hammerspoon automation tool.
        
    - `/.github`: Contains GitHub-specific files like `CODEOWNERS`.
        
    - `/.ssh`: Contains placeholder files for SSH keys, which are encrypted.
        

## 4. Coding Conventions & Style Guide

- **Formatting:**
    
    - **Lua:** The `stylua.toml` and `.luarc.json` files define the formatting rules. It uses 2 spaces for indentation.
        
    - **PHP:** The `.php-cs-fixer.dist.php` file enforces PSR-12 coding standards.
        
    - **General:** The `.editorconfig` file specifies universal settings like `utf-8` charset, `lf` line endings, and trimming trailing whitespace.
        
- **Naming Conventions:** (Inferred from file and directory names)
    
    - **files & directories:** kebab-case or snake_case (e.g., `neo-tree.lua`, `gitstatus.prompt.zsh`).
        
    - **Lua variables/functions:** snake_case is prevalent in the Neovim configuration.
        
- **API Design:** Not applicable.
    
- **Error Handling:** Inferred from shell scripts, error handling is done via checking exit codes and using conditional statements.
    

## 5. Key Files & Entrypoints

- **Main Entrypoint(s):**
    
    - Shell: `config/zsh/.zshrc` and `config/bash/.bashrc`.
        
    - Neovim: `config/nvim/init.lua`.
        
    - Hammerspoon: `hammerspoon/init.lua`.
        
- **Configuration:**
    
    - `.env`: For environment variables.
        
    - `Brewfile`: Defines Homebrew dependencies.
        
    - `stylua.toml`: Lua formatter configuration.
        
    - `.php-cs-fixer.dist.php`: PHP coding standards configuration.
        
- **CI/CD Pipeline:** None detected.
    

## 6. Development & Testing Workflow

- **Local Development Environment:** The `README.md` implies that setup involves cloning the repository and running a setup script (though the script itself is not explicitly named). The `Brewfile` is key to installing all necessary tools.
    
- **Testing:** No formal testing framework or test files were detected.
    
- **CI/CD Process:** Not applicable.
    

## 7. Specific Instructions for AI Collaboration

- **Contribution Guidelines:** The `.github/CODEOWNERS` file indicates that the repository owner (`@jascha030`) is responsible for all files. While there's no formal `CONTRIBUTING.md`, any changes should be discussed with the owner.
    
- **Infrastructure (IaC):** No Infrastructure as Code (IaC) was detected.
    
- **Security:** This repository contains encrypted files managed by `git-secret` (e.g., in the `/.ssh` directory). **Never commit unencrypted secrets.** Any modifications to files ending in `.secret` must be done through `git-secret`.
    
- **Dependencies:** New software dependencies should be added to the `Brewfile`.
    
- **Commit Messages:** (Inferred from general best practices, no specific standard found) It is recommended to follow the Conventional Commits specification (e.g., `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`).