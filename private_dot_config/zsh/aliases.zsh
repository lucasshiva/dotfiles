# Reload zsh config.
alias reload="source $ZDOTDIR/.zshrc"

# Same as cat, but with syntax highlighting.
alias bat="bat -p --color=always"

# Color 'ls' output and group directories.
alias ls="exa --icons --color=always --group-directories-first"
alias la="exa -a --icons --color=always --group-directories-first"
alias ll="exa -lha --icons --color=always --group-directories-first"

# Color ip output
alias ip='ip -color=auto'

# A better way to navigate directories
alias tree="br"

# Git
alias gs="git status"
alias gd="git diff"

# Core commands
alias mkdir="mkdir -p"

# Change fzf matching.
alias fzf="fzf -e"

# Shorten commands.
alias pi="sudo pacman -S --noconfirm"
alias yi="yay -S --noconfirm"
alias ff="fastfetch"
alias ch="chezmoi"
