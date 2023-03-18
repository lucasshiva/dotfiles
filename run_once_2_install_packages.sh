#!/bin/sh

packages=(
    # Applications
    kitty
    firefox
    firefox-developer-edition
    neovim
    obsidian
    spotify
    grub-customizer
    keepassxc

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
    python-pip
    starship
    syncthing
    chezmoi
    cmake
    ffmpeg4.4
    extension-manager
)

package_string=$(printf " %s" "${packages[@]}")
yay -Syu --needed --noconfirm $package_string
