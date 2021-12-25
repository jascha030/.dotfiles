# NVIM Setup

Originally part of my [dotfiles repo](https://github.com/jascha030/dotfiles), but decided to separate the NVIM config, to keep it a bit more organized.

![Screenshot with iTerm2 and TMUX](https://github.com/jascha030/config-nvim/blob/main/screens/screen.png)

## Getting Started

### Prerequisites

* NeoVim: ^0.5

This config is written in lua which is only supported from NeoVim 0.5 upwards.

### Installation

**Install NeoVim with your preferred package manager**

Example uses homebrew for MacOS, for other oprions check the [neovim repo docs](https://github.com/neovim/neovim).

```shell
brew install neovim
```


**Clone the repo:**

```shell
git clone git@github.com:jascha030/config-nvim.git
```

**Move to $XDG_CONFIG_HOME**
 
 You could either directly clone this repo to your config dir (`$HOME/.config` on macOS), or what I would recommend is to symlink the repo to this directory and store it somewhere else (in my case I keep it inside a folder in my dotfiles repo).

**Symlink example**

```shell
ln -s path/to/git/repo/ $HOME/.config/nvim
```


