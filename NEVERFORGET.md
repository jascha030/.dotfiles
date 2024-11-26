# YDOIALWAYZ4GET

## (NEO)VIM

### (N)Vim bomp command output to buffer

```vim
:redir @"
:<DO COMMANDS HERE>
:redir END
:enew|put
```

## ln -s from .ssh in dotfiles

```bash
lsd -I $HOME'/.ssh/*.secret' --icon never -1 \
| xargs realpath \
| xargs -J % ln -s -- % $HOME/.ssh/
```
