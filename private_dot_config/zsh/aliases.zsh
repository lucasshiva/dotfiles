# Reload zsh config.
alias reload="source $ZDOTDIR/.zshrc"

# Same as cat, but with syntax highlighting.
alias bat="bat -p --color=always"

# Color 'ls' output and group directories.
alias ls="exa -a --icons --color=always --group-directories-first"
alias ll="exa -lha --icons --color=always --group-directories-first"

# A search tool that combines the usability of ag with the raw speed of grep.
alias grep="rg"

# Color ip output
alias ip='ip -color=auto'

# A better way to navigate directories
alias tree="br"

# Git
alias gs="git status"
alias gd="git diff"

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -vI"
alias mkdir="mkdir -pv"

# Change fzf matching.
alias fzf="fzf -e"

# Shorten commands.
alias pi="sudo pacman -S"
alias yi="yay -S"
alias ff="fastfetch"
alias ch="chezmoi"
