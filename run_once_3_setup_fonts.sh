#!/bin/sh

# - Install fonts.
packages=(
    noto-fonts
    noto-fonts-cjk
    ttf-opensans
    nerd-fonts-fantasque-sans-mono
    ttf-bookerly
    ttf-lato
    ttf-ubuntu-font-family
    otf-spectral
    nerd-fonts-jetbrains-mono
    ttf-firacode-nerd
    ttf-merriweather
    ttf-merriweather-sans
    ttf-sourcecodepro-nerd
    nerd-fonts-dejavu-complete
)

package_string=$(printf " %s" "${packages[@]}")
yay -S --needed --noconfirm $package_string


# - Get fonts from Windows

# Path to the Windows 10 C: partition. Leave it blank if you don't have a Windows 
# partition, or simply do not want to install its fonts.
windows_dir="/Windows10/System"

# Check if directory exists
# This will not run if the directory is an empty string.
if [[ $windows_dir && -d $windows_dir ]]; then
    # Create fonts directory.
    sudo mkdir /usr/share/fonts/WindowsFonts

    # Copy all fonts from Windows partition to the fonts directory.
    sudo cp ${windows_dir}/Windows/Fonts/* /usr/share/fonts/WindowsFonts/

    # Change fonts permission.
    sudo chmod 644 /usr/share/fonts/WindowsFonts/*
fi

# Regenerate the fontconfig cache
fc-cache -f