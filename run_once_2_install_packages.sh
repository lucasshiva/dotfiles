#!/bin/sh

packages=(
    # Applications
    kitty
    chromium
    firefox
    discord
    neovim
    neovide
    calibre
    baobab
    bitwarden
    gammy
    obsidian
    spotify
    mailspring
    pcloud-drive
    grub-customizer
    joplin-appimage
    ffmpeg-compat-57

    # Utilities
    xarchiver
    fastfetch
    base-devel
    gnome-keyring
    ntfs-3g
    dosfstools
    mtools
    bat
    exa
    fd
    broot
    mlocate
    which
    reflector
    numlockx
    zenity
    zoxide
    duf
    git-delta
    man-db
    libappindicator-gtk3
    ripgrep
    xclip
    fzf
    file-roller
    nemo-fileroller
    noise-suppression-for-voice
    python-pip
    starship
    syncthing
)

package_string=$(printf " %s" "${packages[@]}")
yay -Syu --needed --noconfirm $package_string
