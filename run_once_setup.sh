#!/bin/bash

main() {
    # Avoid running `-Syu` every time we call `install_packages`.
    sudo pacman -Syu

    setup_core
    setup_yay
    setup_zsh
    setup_fonts
    setup_packages
    setup_gnome
}

setup_gnome() {
    # Load dconf settings
    dconf load / < dconf-settings.ini

    # Manually set wallpaper
    wallpaper_path=$(readlink -f ./wallpaper.jpg)
    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper_path"
    gsettings set org.gnome.desktop.screensaver picture-uri "file://$wallpaper_path"

    # Removes "Window is ready" message.
    gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'smart'
}

setup_yay() {
    if ! command_exists yay; 
    then
        sudo pacman -S --needed --noconfirm git go base-devel
        git clone https://aur.archlinux.org/yay.git "$HOME/yay"
        cd "$HOME/yay"
        makepkg -si
    fi

    # Uncomment the `Color` and `ParallelDownloads` lines if needed.
    sudo sed -i "/Color/s/^#//g" /etc/pacman.conf
    sudo sed -i '/ParallelDownloads/s/^#//g' /etc/pacman.conf
}

setup_zsh() {
    packages=(
        zsh
        zsh-completions
        zsh-syntax-highlighting
        zsh-autosuggestions
    )
    install_packages $packages

    is_zsh=`echo $0 | grep zsh`
    if [[ ! $is_zsh ]];
    then
        zsh_path=`which zsh`
        sudo chsh -s $zsh_path $USER
    fi
}

setup_core() {
    # Setup some core packages we might need.
    packages=(
        coreutils
        usbutils
        base-devel
        git
        findutils
        which
        mlocate
        ntfs-3g
        dosfstools
        mtools
        sd
    )

    install_packages $packages
}

install_packages() {
    packages=$1
    package_string=$(printf " %s" "${packages[@]}")

    # TODO: Add more package managers, such as Paru, Amethyst, etc.
    if command_exists yay; then
        yay -S --needed $package_string
    else
        pacman -S --needed $package_string
    fi
}

setup_fonts() {
    packages=(
        noto-fonts
        noto-fonts-cjk
        ttf-opensans
        ttf-fantasque-nerd
        ttf-lato
        ttf-ubuntu-font-family
        otf-spectral
        ttf-jetbrains-mono-nerd
        ttf-firacode-nerd
        ttf-merriweather
        ttf-merriweather-sans
        ttf-sourcecodepro-nerd
        ttf-dejavu-nerd
        otf-monaspace-nerd
        ttf-mononoki-nerd
        inter-font
    )

    install_packages $packages

    # If we find the Windows system partition, copy the fonts.
    # In my case, it's mostly `/mnt/windows/system`.
    # NOTE: We could also try searching for the directory automatically.
    windows_dir="/mnt/Windows/System"

    if [[ $windows_dir && -d $windows_dir ]]; then
        sudo mkdir /usr/share/fonts/WindowsFonts &> /dev/null
        sudo cp ${windows_dir}/Windows/Fonts/* /usr/share/fonts/WindowsFonts/
        sudo chmod 644 /usr/share/fonts/WindowsFonts/*
    fi

    fc-cache -f
}

setup_packages() {
    packages=(
        # Applications
        kitty
        firefox
        firefox-developer-edition
        google-chrome
        neovim
        obsidian-bin
        spotify
        # Optional deps for Spotify
        zenity
        libnotify
        ffmpeg4.4

        grub-customizer
        keepassxc
        visual-studio-code-bin

        # Theming
        papirus-icon-theme 
        arc-gtk-theme 
        catppuccin-gtk-theme-mocha 
        catppuccin-mocha-light-cursors
        bibata-cursor-theme

        # Utilities
        xarchiver
        fastfetch
        gnome-keyring
        bat
        exa
        fd
        broot
        reflector
        numlockx
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
        cmake
        extension-manager
    )

    install_packages $packages
}

package_exists() {
    pacman -Qq "$1" &> /dev/null; 
}

command_exists() {
    type "$1" &> /dev/null;
}

main "$@"
