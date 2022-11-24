#!/bin/sh

# Install yay
if type -p yay >/dev/null; then
    echo "Yay is already installed!"
else
    sudo pacman -S --needed --noconfirm git go base-devel
    git clone https://aur.archlinux.org/yay.git "$HOME/yay"
    cd "$HOME/yay"
    makepkg -si
fi

# Edit pacman.conf
sudo sed -i "/Color/s/^#//g" /etc/pacman.conf
sudo sed -i '/ParallelDownloads/s/^#//g' /etc/pacman.conf
