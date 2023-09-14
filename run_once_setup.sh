#!/bin/bash

main() {
    # Avoid running `-Syu` every time we call `install_packages`.
    sudo pacman -Syu

    setup_core
    setup_yay
    setup_zsh
    setup_fonts
    setup_packages
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
        yay -S --needed --noconfirm $package_string
    else
        pacman -S --needed --noconfirm $package_string
    fi
}

setup_fonts() {
    fonts=(
        noto-fonts
        noto-fonts-cjk
        ttf-opensans
        ttf-fantasque-nerd
        ttf-bookerly
        ttf-lato
        ttf-ubuntu-font-family
        otf-spectral
        ttf-jetbrains-mono-nerd
        ttf-firacode-nerd
        ttf-merriweather
        ttf-merriweather-sans
        ttf-sourcecodepro-nerd
        ttf-dejavu-nerd
    )

    install_packages $fonts

    # If we find the Windows system partition, copy the fonts.
    # In my case, it's mostly `/mnt/windows/system`.
    # NOTE: We could also try searching for the directory automatically.
    windows_dir="/mnt/windows/system"

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
        chromium
        neovim
        obsidian
        spotify
        grub-customizer
        keepassxc
        visual-studio-code-bin

        # Theming
        papirus-icon-theme 
        arc-gtk-theme 
        catppuccin-gtk-theme-mocha 
        catppuccin-mocha-light-cursors

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
        cmake
        ffmpeg4.4
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