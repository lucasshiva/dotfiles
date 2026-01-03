#!/usr/bin/env bash

# Packages and utilities not managed by Nix/Home Manager.

set -euo pipefail

if ! command -v yay >/dev/null; then
    echo "yay is not installed. Please install yay first."
    return 2>/dev/null || exit
fi


install_packages() {
    if [[ $# -eq 0 ]]; then
        echo "No packages provided to install."
        return
    fi

    echo "Installing packages: $*"
    # Install all packages at once
    yay -S --noconfirm --needed "$@"
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
CORE=(
    base-devel
    wget
    curl
    visual-studio-code-bin
    kitty
)

AUDIO=(
    pipewire
    lib32-pipewire
    pipewire-alsa
    pipewire-jack
    lib32-pipewire-jack
    pipewire-pulse
    wirepumbler
)

DEV_TOOLS=(
    rider
    android-studio
    dotnet-sdk 
    dotnet-sdk-9.0
    aspnet-targeting-pack # Solves error NETSDK1226: Prune Package data not found
    uv
)

UTILS=(
    pacsea-bin # Manage pacman via a TUI.
    wl-clipboard # For Wayland clipboard support.
    duf # Disk usage/free utility - a `df` alternative.
    fd # A simple, fast, and user-friendly alternative to find.
    sd # An intuitive find & replace CLI (sed alternative)
    xwayland-satellite # For Niri
    hunspell-en_US # Spell checking for American English
)

MEDIA=(
    stremio
    steam # Check the Arch Wiki on how to set up Steam correctly.
)

DESKTOP=(
    niri
    firefox
    firefox-developer-edition
)

# --- Usage / Help ---
print_help() {
    cat << EOF
Usage: $0 [categories]

Install selected categories of packages.

Categories (comma or space-separated):
  core       - Base system packages
  audio      - Audio packages
  dev        - Development tools
  utils      - Utility programs
  media      - Media applications
  desktop    - Desktop environments / compositors

Examples:
  $0              # Install all categories
  $0 utils        # Install only utilities
  $0 core,dev     # Install core + dev packages
  $0 utils media  # Mix space-separated categories

Options:
  -h, --help      Show this help message
EOF
}

# --- Parse CLI arguments ---
if [[ $# -gt 0 ]]; then
    for arg in "$@"; do
        case "$arg" in
            -h|--help)
                print_help
                exit 0
                ;;
        esac
    done
fi

SELECTED_CATEGORIES=()

if [[ $# -eq 0 ]]; then
    # No arguments → install everything
    SELECTED_CATEGORIES=("core" "audio" "dev" "utils" "media" "desktop")
else
    # Split comma-separated input into array
    for arg in "$@"; do
        [[ "$arg" == "-h" || "$arg" == "--help" ]] && continue
        IFS=',' read -ra split <<< "$arg"
        for cat in "${split[@]}"; do
            cat=$(echo "$cat" | xargs)
            SELECTED_CATEGORIES+=("$cat")
        done
    done
fi


# --- Install packages based on chosen categories ---
for category in "${SELECTED_CATEGORIES[@]}"; do
    case "$category" in
        core)
            echo "Installing core packages..."
            install_packages "${CORE[@]}"
            ;;
        audio)
            echo "Installing audio packages..."
            install_packages "${AUDIO[@]}"
            ;;
        dev)
            echo "Installing development tools..."
            install_packages "${DEV_TOOLS[@]}"
            echo "Installing FVM..."
            install_fvm
            ;;
        utils)
            echo "Installing utilities..."
            install_packages "${UTILS[@]}"
            ;;
        media)
            echo "Installing media applications..."
            install_packages "${MEDIA[@]}"
            ;;
        desktop)
            echo "Installing desktop packages..."
            install_packages "${DESKTOP[@]}"
            ;;
        *)
            echo "Unknown category: $category"
            ;;
    esac
done
