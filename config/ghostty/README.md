# 👻 Ghostty Configuration

<div align="center">
  <img src="../../img/term.gif" alt="Terminal Demo" width="100%" />
</div>

## 📖 Overview

A configuration for **Ghostty**, the high-performance, native-feeling terminal emulator. This setup focuses on aesthetic minimalism, speed, and leveraging Ghostty's unique features like shaders and rich styling.

## ✨ Features

- **⚡ Native Performance**: Extremely low latency and resource usage.
- **🦄 Custom Shaders**: Configured to use custom GLSL shaders (e.g., CRT effects) when I'm feeling nostalgic.
- **🎨 Dual Themes**: Custom `litepal`/`nitepal` themes that sync with system appearance.
- **🔳 Window Management**: Tiling-friendly window padding and decoration settings.
- **🔮 Holographic Icons**: Uses Ghostty's macOS-specific icon features.

## 📂 File Structure

Ghostty uses a flat configuration file structure, but I organize themes separately:

```text
config/ghostty/
├── config              # Main configuration file
└── themes/             # Custom theme definitions
    ├── litepa11y       # Light mode (Accessible)
    ├── litepal         # Light mode (Standard)
    ├── nitepa11y       # Dark mode (Accessible)
    └── nitepal         # Dark mode (Standard)
```

## ⌨️ Keybindings

I've mapped Ghostty to behave similarly to my WezTerm/Tmux workflow using `Ctrl` + `d` as a prefix.

| Keys | Action |
| :--- | :--- |
| `Ctrl+d` `c` | New Tab |
| `Ctrl+d` `v` | Split Right |
| `Ctrl+d` `s` | Split Down |
| `Ctrl+d` `z` | Toggle Split Zoom |
| `Ctrl+d` `h/l` | Previous/Next Tab |
| `Ctrl+d` `x` | Close Surface |
| `Alt` + `Arrows` | Jump between splits |
| `Super` + `Enter` | Toggle Fullscreen |

## 🎨 Themes

The configuration is set to automatically switch between light and dark variants of my custom palettes:

```ini
theme = light:litepa11y,dark:nitepa11y
```
