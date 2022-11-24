# Colored man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Search and install Pacman and AUR packages with fzf.
# For this to work properly you need to run "sudo pacman -Fy" at least once.
pacview() {
  pacman -Sl |
  sd '^\w+ ' '' |       # Remove the repository name.
  sort -u |     # Remove duplicates.
  awk '{print $1($3=="" ? "" : " *")}' |
  fzf -q "$1" -m -e \
  --header='Search packages' \
  --preview='bat -n --color=always <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")' \
  --preview-window right,65%,wrap \
  --info=hidden \
  --layout=reverse-list \
  --ansi |
  xargs -ro sudo pacman -S
}

aurfind() {
  yay -Sl |
  sd '^\w+ ' '' |
  sort -u |
  awk '{print $1($3=="" ? "" : " *")}' |
  fzf -q "$1" -m -e \
  --header='Search packages' \
  --preview='bat -n --color=always <(yay -Si {1})' \
  --preview-window right,65%,wrap \
  --info=hidden \
  --bind=ctrl-p:preview:'bat -n --color=always <(curl -s https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD\?h={1})' \
  --bind=ctrl-x:preview:'bat -n --color=always <(yay -Si {1})' \
  --layout=reverse-list \
  --ansi |
  xargs -ro yay -S
}

# Browse installed packages.
paclist() {
  pacman -Qqe |
  fzf -q "$1" -m -e \
  --header='Search packages' \
  --preview='bat -n --color=always <(yay -Si {1})' \
  --preview-window right,65%,wrap \
  --info=hidden \
  --ansi \
  --layout=reverse-list |
  xargs -ro sudo pacman -S
}

pacfind() {
  pacman -Slq |
  fzf --prompt 'pacman> ' \
  --header 'Install packages.' \
  --bind 'ctrl-p:change-prompt(pacman> )+reload(pacman -Slq)' \
  --bind 'ctrl-a:change-prompt(aur> )+reload(yay -Slq)' \
  --multi --black --height=80% --preview 'yay -Si {1}' \
  --preview-window bottom | xargs -ro yay -S
}
