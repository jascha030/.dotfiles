# 🔨 Hammerspoon Configuration

## 📖 Overview

This directory contains Lua scripts for [Hammerspoon](https://www.hammerspoon.org/), the powerful automation tool for macOS. My configuration focuses on window management, application toggling, and system workflows.

It uses a custom module loader `JSpoon` to organize functionality.

## ✨ Features

- **🪟 Tiling Window Management**: Instant, zero-latency window placement.
- **📟 Quake Mode**: Toggle a drop-down terminal (WezTerm/Ghostty) from anywhere.
- **🌗 Dark Mode Toggle**: One keystroke to switch system appearance.
- **⚡ Hotkey Layers**: Semantic grouping of hotkeys (System, Control, Apps).

## ⌨️ Hotkeys

The configuration uses specific modifier sets for different contexts:

### ⚙️ System Layer
**Modifiers:** `Ctrl` + `Alt` + `Cmd`

| Key | Action |
| :--- | :--- |
| `D` | **Toggle Dark Mode** (System-wide) |
| `T` | **Toggle Terminal** (Quake Mode) |

### 🎮 Control Layer (Window Management)
**Modifiers:** `Ctrl` + `Alt`

| Key | Action |
| :--- | :--- |
| `H` / `Left` | Move Window **Left** (50%) |
| `L` / `Right` | Move Window **Right** (50%) |
| `J` / `K` / `Up` | **Center** Window |
| `Down` | **Minimize** / Shrink |
| `Return` | **Maximize** Window |

### 🚀 App Layer (Quake Toggles)
**Modifiers:** `Shift` + `Alt`

Instantly show/hide specific applications:

| Key | App |
| :--- | :--- |
| `I` | Music |
| `S` | Spotify |
| `P` | PhpStorm |
| `L` | Ableton Live |
| `C` | Chrome |
| `K` | GitKraken |
| `N` | Notes |
| `A` | Safari |

## 📂 Structure

```text
hammerspoon/
├── init.lua            # Entry point & Configuration Table
└── jascha030/          # Core Logic
    ├── init.lua        # JSpoon Loader
    ├── hotkey.lua      # Hotkey registration engine
    ├── window.lua      # Window manipulation logic
    ├── quake.lua       # Application toggle logic
    └── ...
```
