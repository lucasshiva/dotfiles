#!/usr/bin/env bash

# Packages and utilities not managed by Nix/Home Manager.

set -euo pipefail

if ! command -v yay >/dev/null; then
    echo "yay is not installed. Please install yay first."
    exit 1
fi


install_packages() {
    for package in "$@"; do
        if yay -Qi "$package" >/dev/null 2>&1; then
            echo "✓ $package already installed"
        else
            echo "→ Installing $package"
            yay -S --noconfirm --needed "$package"
        fi
    done
}

install_fvm() {
    if command -v fvm >/dev/null; then
        echo "FVM is already installed."
        return
    fi

    echo "Installing FVM - Flutter Version Manager..."
    
    # Linux desktop dependencies for Flutter.
    sudo pacman -S ninja cmake --noconfirm --needed

    curl -fsSL https://fvm.app/install.sh | bash
}

# Essential packages for a good base system.
# Depending on how we install Arch, or which arch-based distro we use, some of these packages might be missing.
CORE = (
    base-devel
)

DEV_TOOLS = (
    visual-studio-code-bin
    rider
    android-studio
    dotnet-sdk 
    dotnet-sdk-9.0
    uv
)

UTILS = (
    pacsea-bin # Manage pacman via a TUI.
)

MEDIA = (
    stremio
)

echo "Installing core packages..."
install_packages "${CORE[@]}"

echo "Installing dev tools.."
install_packages "${DEV_TOOLS[@]}"

echo "Installing utilities..."
install_packages "${UTILS[@]}"

echo "Installing media applications..."
install_packages "${MEDIA[@]}"

install_fvm
