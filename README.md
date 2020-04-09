# .dotfiles
Backup of my .dotfiles (zsh, bash, git, npm)

In case of new install.

```shell
brew install stow

cd ~

git clone git@github.com:jascha030/.dotfiles.git
```

Next run `stow` on each subdirectory.

Example:
```shell
cd ~/.dotfiles

stow zsh #example
```
