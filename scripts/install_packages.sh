#!/usr/bin/env bash

# This scripts is for packages we can't or don't want to install via home-manager and Nix.

set -e

if ! command -v yay >/dev/null; then
    echo "yay is not installed. Please install yay first."
    exit 1
fi


install_package() {
    for package in "$@"; do
        echo "Installing ${package}..."
        yay -S --noconfirm --needed "${package}"
        return
    done
}

install_fvm() {
    echo "Installing FVM - Flutter Version Manager..."
    curl -fsSL https://fvm.app/install.sh | bash
}

install_package visual-studio-code-bin
install_package dotnet-sdk dotnet-sdk-9.0
install_package uv
install_fvm
