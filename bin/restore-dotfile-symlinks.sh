#!/bin/sh

: "${HOME:?}"

mkdir -p "$HOME"
if [ ! -e "$HOME/.my.cnf" ] && [ ! -L "$HOME/.my.cnf" ]; then ln -s "$HOME/.dotfiles/my.cnf" "$HOME/.my.cnf"; fi
mkdir -p "$HOME"
if [ ! -e "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then ln -s "$HOME/.dotfiles/config/bash/.bashrc" "$HOME/.bashrc"; fi
mkdir -p "$HOME"
if [ ! -e "$HOME/.ignition.json" ] && [ ! -L "$HOME/.ignition.json" ]; then ln -s "$HOME/.dotfiles/config/.ignition.json" "$HOME/.ignition.json"; fi
mkdir -p "$HOME"
if [ ! -e "$HOME/.gitignore_global" ] && [ ! -L "$HOME/.gitignore_global" ]; then ln -s "$HOME/.dotfiles/gitignore_global" "$HOME/.gitignore_global"; fi
mkdir -p "$HOME"
if [ ! -e "$HOME/.zshenv" ] && [ ! -L "$HOME/.zshenv" ]; then ln -s "$HOME/.dotfiles/config/zsh/.zshenv" "$HOME/.zshenv"; fi
mkdir -p "$HOME"
if [ ! -e "$HOME/.env" ] && [ ! -L "$HOME/.env" ]; then ln -s "$HOME/.dotfiles/.env" "$HOME/.env"; fi
mkdir -p "$HOME"
if [ ! -e "$HOME/.hushlogin" ] && [ ! -L "$HOME/.hushlogin" ]; then ln -s "$HOME/.dotfiles/hushlogin" "$HOME/.hushlogin"; fi
mkdir -p "$HOME"
if [ ! -e "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then ln -s "$HOME/.dotfiles/gitconfig" "$HOME/.gitconfig"; fi
mkdir -p "$HOME"
if [ ! -e "$HOME/.myclirc" ] && [ ! -L "$HOME/.myclirc" ]; then ln -s "$HOME/.dotfiles/config/mycli/.myclirc" "$HOME/.myclirc"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/.php-cs-fixer.dist.php" ] && [ ! -L "$HOME/.config/.php-cs-fixer.dist.php" ]; then ln -s "$HOME/.dotfiles/config/.php-cs-fixer.dist.php" "$HOME/.config/.php-cs-fixer.dist.php"; fi
mkdir -p "$HOME/.config/alacritty"
if [ ! -e "$HOME/.config/alacritty/default.yml" ] && [ ! -L "$HOME/.config/alacritty/default.yml" ]; then ln -s "$HOME/.dotfiles/config/alacritty/default.yml" "$HOME/.config/alacritty/default.yml"; fi
mkdir -p "$HOME/.config/alacritty"
if [ ! -e "$HOME/.config/alacritty/alacritty.yml" ] && [ ! -L "$HOME/.config/alacritty/alacritty.yml" ]; then ln -s "$HOME/.dotfiles/config/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"; fi
mkdir -p "$HOME/.config/alacritty"
if [ ! -e "$HOME/.config/alacritty/colors.yml" ] && [ ! -L "$HOME/.config/alacritty/colors.yml" ]; then ln -s "$HOME/.dotfiles/config/alacritty/colors.yml" "$HOME/.config/alacritty/colors.yml"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/mise" ] && [ ! -L "$HOME/.config/mise" ]; then ln -s "$HOME/.dotfiles/config/mise" "$HOME/.config/mise"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/vivid" ] && [ ! -L "$HOME/.config/vivid" ]; then ln -s "$HOME/.dotfiles/config/vivid" "$HOME/.config/vivid"; fi
mkdir -p "$HOME/.config/nvim"
if [ ! -e "$HOME/.config/nvim/init.lua" ] && [ ! -L "$HOME/.config/nvim/init.lua" ]; then ln -s "$HOME/.dotfiles/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"; fi
mkdir -p "$HOME/.config/nvim"
if [ ! -e "$HOME/.config/nvim/lua" ] && [ ! -L "$HOME/.config/nvim/lua" ]; then ln -s "$HOME/.dotfiles/config/nvim/lua" "$HOME/.config/nvim/lua"; fi
mkdir -p "$HOME/.config/nvim"
if [ ! -e "$HOME/.config/nvim/lazy-lock.json" ] && [ ! -L "$HOME/.config/nvim/lazy-lock.json" ]; then ln -s "$HOME/.dotfiles/config/nvim/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"; fi
mkdir -p "$HOME/.config/nvim"
if [ ! -e "$HOME/.config/nvim/after" ] && [ ! -L "$HOME/.config/nvim/after" ]; then ln -s "$HOME/.dotfiles/config/nvim/after" "$HOME/.config/nvim/after"; fi
mkdir -p "$HOME/.config/lazygit"
if [ ! -e "$HOME/.config/lazygit/config.yml" ] && [ ! -L "$HOME/.config/lazygit/config.yml" ]; then ln -s "$HOME/.dotfiles/config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/wezterm" ] && [ ! -L "$HOME/.config/wezterm" ]; then ln -s "$HOME/.dotfiles/config/wezterm" "$HOME/.config/wezterm"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/starship.toml" ] && [ ! -L "$HOME/.config/starship.toml" ]; then ln -s "$HOME/.dotfiles/config/starship.toml" "$HOME/.config/starship.toml"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/lsd" ] && [ ! -L "$HOME/.config/lsd" ]; then ln -s "$HOME/.dotfiles/config/lsd" "$HOME/.config/lsd"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/lua" ] && [ ! -L "$HOME/.config/lua" ]; then ln -s "$HOME/.dotfiles/config/lua" "$HOME/.config/lua"; fi
mkdir -p "$HOME/.config/bash"
if [ ! -e "$HOME/.config/bash/bin" ] && [ ! -L "$HOME/.config/bash/bin" ]; then ln -s "$HOME/.dotfiles/config/bash/bin" "$HOME/.config/bash/bin"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/nushell" ] && [ ! -L "$HOME/.config/nushell" ]; then ln -s "$HOME/.dotfiles/config/nushell" "$HOME/.config/nushell"; fi
mkdir -p "$HOME/.config/phpactor"
if [ ! -e "$HOME/.config/phpactor/phpactor.yml" ] && [ ! -L "$HOME/.config/phpactor/phpactor.yml" ]; then ln -s "$HOME/.dotfiles/config/phpactor/phpactor.yml" "$HOME/.config/phpactor/phpactor.yml"; fi
mkdir -p "$HOME/.config/phpactor"
if [ ! -e "$HOME/.config/phpactor/phpactor.json" ] && [ ! -L "$HOME/.config/phpactor/phpactor.json" ]; then ln -s "$HOME/.dotfiles/config/phpactor/phpactor.json" "$HOME/.config/phpactor/phpactor.json"; fi
mkdir -p "$HOME/.config/phpactor"
if [ ! -e "$HOME/.config/phpactor/templates" ] && [ ! -L "$HOME/.config/phpactor/templates" ]; then ln -s "$HOME/.dotfiles/config/phpactor/templates" "$HOME/.config/phpactor/templates"; fi
mkdir -p "$HOME/.config/erdtree"
if [ ! -e "$HOME/.config/erdtree/.erdtree.toml" ] && [ ! -L "$HOME/.config/erdtree/.erdtree.toml" ]; then ln -s "$HOME/.dotfiles/config/.erdtree.toml" "$HOME/.config/erdtree/.erdtree.toml"; fi
mkdir -p "$HOME/.config/zellij"
if [ ! -e "$HOME/.config/zellij/config.kdl" ] && [ ! -L "$HOME/.config/zellij/config.kdl" ]; then ln -s "$HOME/.dotfiles/config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"; fi
mkdir -p "$HOME/.config/tmux"
if [ ! -e "$HOME/.config/tmux/tmux.conf" ] && [ ! -L "$HOME/.config/tmux/tmux.conf" ]; then ln -s "$HOME/.dotfiles/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"; fi
mkdir -p "$HOME/.config/tmux/scripts/phpver"
if [ ! -e "$HOME/.config/tmux/scripts/phpver/version.zsh" ] && [ ! -L "$HOME/.config/tmux/scripts/phpver/version.zsh" ]; then ln -s "$HOME/.dotfiles/config/tmux/scripts/phpver/version.zsh" "$HOME/.config/tmux/scripts/phpver/version.zsh"; fi
mkdir -p "$HOME/.config/tmux/scripts/battery"
if [ ! -e "$HOME/.config/tmux/scripts/battery/status.zsh" ] && [ ! -L "$HOME/.config/tmux/scripts/battery/status.zsh" ]; then ln -s "$HOME/.dotfiles/config/tmux/scripts/battery/status.zsh" "$HOME/.config/tmux/scripts/battery/status.zsh"; fi
mkdir -p "$HOME/.config/tmux/scripts/battery"
if [ ! -e "$HOME/.config/tmux/scripts/battery/battery.zsh" ] && [ ! -L "$HOME/.config/tmux/scripts/battery/battery.zsh" ]; then ln -s "$HOME/.dotfiles/config/tmux/scripts/battery/battery.zsh" "$HOME/.config/tmux/scripts/battery/battery.zsh"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/eza" ] && [ ! -L "$HOME/.config/eza" ]; then ln -s "$HOME/.dotfiles/config/eza" "$HOME/.config/eza"; fi
mkdir -p "$HOME/.config/lla"
if [ ! -e "$HOME/.config/lla/config.toml" ] && [ ! -L "$HOME/.config/lla/config.toml" ]; then ln -s "$HOME/.dotfiles/config/lla/config.toml" "$HOME/.config/lla/config.toml"; fi
mkdir -p "$HOME/.config/lla"
if [ ! -e "$HOME/.config/lla/themes" ] && [ ! -L "$HOME/.config/lla/themes" ]; then ln -s "$HOME/.dotfiles/config/lla/themes" "$HOME/.config/lla/themes"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/bat" ] && [ ! -L "$HOME/.config/bat" ]; then ln -s "$HOME/.dotfiles/config/bat" "$HOME/.config/bat"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/stylua.toml" ] && [ ! -L "$HOME/.config/stylua.toml" ]; then ln -s "$HOME/.dotfiles/stylua.toml" "$HOME/.config/stylua.toml"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/overrides" ] && [ ! -L "$HOME/.config/zsh/overrides" ]; then ln -s "$HOME/.dotfiles/config/zsh/overrides" "$HOME/.config/zsh/overrides"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/init" ] && [ ! -L "$HOME/.config/zsh/init" ]; then ln -s "$HOME/.dotfiles/config/zsh/init" "$HOME/.config/zsh/init"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/plugins-spec" ] && [ ! -L "$HOME/.config/zsh/plugins-spec" ]; then ln -s "$HOME/.dotfiles/config/zsh/plugins-spec" "$HOME/.config/zsh/plugins-spec"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/bin" ] && [ ! -L "$HOME/.config/zsh/bin" ]; then ln -s "$HOME/.dotfiles/config/zsh/bin" "$HOME/.config/zsh/bin"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/.zshrc" ] && [ ! -L "$HOME/.config/zsh/.zshrc" ]; then ln -s "$HOME/.dotfiles/config/zsh/.zshrc" "$HOME/.config/zsh/.zshrc"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/auto-ls" ] && [ ! -L "$HOME/.config/zsh/auto-ls" ]; then ln -s "$HOME/.dotfiles/config/zsh/auto-ls" "$HOME/.config/zsh/auto-ls"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/timing" ] && [ ! -L "$HOME/.config/zsh/timing" ]; then ln -s "$HOME/.dotfiles/config/zsh/timing" "$HOME/.config/zsh/timing"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/zfunc" ] && [ ! -L "$HOME/.config/zsh/zfunc" ]; then ln -s "$HOME/.dotfiles/config/zsh/zfunc" "$HOME/.config/zsh/zfunc"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/prompt" ] && [ ! -L "$HOME/.config/zsh/prompt" ]; then ln -s "$HOME/.dotfiles/config/zsh/prompt" "$HOME/.config/zsh/prompt"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/aliases" ] && [ ! -L "$HOME/.config/zsh/aliases" ]; then ln -s "$HOME/.dotfiles/config/zsh/aliases" "$HOME/.config/zsh/aliases"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/fzf" ] && [ ! -L "$HOME/.config/zsh/fzf" ]; then ln -s "$HOME/.dotfiles/config/zsh/fzf" "$HOME/.config/zsh/fzf"; fi
mkdir -p "$HOME/.config/zsh"
if [ ! -e "$HOME/.config/zsh/lazyfunctions" ] && [ ! -L "$HOME/.config/zsh/lazyfunctions" ]; then ln -s "$HOME/.dotfiles/config/zsh/lazyfunctions" "$HOME/.config/zsh/lazyfunctions"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/nap" ] && [ ! -L "$HOME/.config/nap" ]; then ln -s "$HOME/.dotfiles/config/nap" "$HOME/.config/nap"; fi
mkdir -p "$HOME/.config/fish"
if [ ! -e "$HOME/.config/fish/config.fish" ] && [ ! -L "$HOME/.config/fish/config.fish" ]; then ln -s "$HOME/.dotfiles/config/fish/config.fish" "$HOME/.config/fish/config.fish"; fi
mkdir -p "$HOME/.config/fish"
if [ ! -e "$HOME/.config/fish/functions" ] && [ ! -L "$HOME/.config/fish/functions" ]; then ln -s "$HOME/.dotfiles/config/fish/functions" "$HOME/.config/fish/functions"; fi
mkdir -p "$HOME/.config/opencode"
if [ ! -e "$HOME/.config/opencode/agents" ] && [ ! -L "$HOME/.config/opencode/agents" ]; then ln -s "$HOME/.dotfiles/config/opencode/agents" "$HOME/.config/opencode/agents"; fi
mkdir -p "$HOME/.config/opencode"
if [ ! -e "$HOME/.config/opencode/opencode.json" ] && [ ! -L "$HOME/.config/opencode/opencode.json" ]; then ln -s "$HOME/.dotfiles/config/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"; fi
mkdir -p "$HOME/.config/opencode"
if [ ! -e "$HOME/.config/opencode/skills" ] && [ ! -L "$HOME/.config/opencode/skills" ]; then ln -s "$HOME/.dotfiles/config/opencode/skills" "$HOME/.config/opencode/skills"; fi
mkdir -p "$HOME/.config/opencode"
if [ ! -e "$HOME/.config/opencode/AGENTS.md" ] && [ ! -L "$HOME/.config/opencode/AGENTS.md" ]; then ln -s "$HOME/.dotfiles/config/opencode/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"; fi
mkdir -p "$HOME/.config/opencode"
if [ ! -e "$HOME/.config/opencode/tui.json" ] && [ ! -L "$HOME/.config/opencode/tui.json" ]; then ln -s "$HOME/.dotfiles/config/opencode/tui.json" "$HOME/.config/opencode/tui.json"; fi
mkdir -p "$HOME/.config"
if [ ! -e "$HOME/.config/ghostty" ] && [ ! -L "$HOME/.config/ghostty" ]; then ln -s "$HOME/.dotfiles/config/ghostty" "$HOME/.config/ghostty"; fi
