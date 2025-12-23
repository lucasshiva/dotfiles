#!/usr/bin/env bash

# This scripts is for packages we can't or don't want to install via home-manager and Nix.

set -e

if ! command -v yay >/dev/null; then
    echo "yay is not installed. Please install yay first."
    exit 1
fi


install_package() {
    for package in "$@"; do
        if yay -Qi "${package}" >/dev/null 2>&1; then
            echo "${package} is already installed."
            continue
        fi

        echo "Installing ${package}..."
        yay -S --noconfirm --needed "${package}"
        return
    done
}

install_fvm() {
    if command -v fvm >/dev/null; then
        echo "FVM is already installed."
        return
    fi

    echo "Installing FVM - Flutter Version Manager..."
    sudo pacman -S ninja cmake --noconfirm --needed
    curl -fsSL https://fvm.app/install.sh | bash
}

install_package visual-studio-code-bin
install_package rider
install_package android-studio
install_package dotnet-sdk dotnet-sdk-9.0
install_package uv
install_fvm
