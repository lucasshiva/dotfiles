#!/usr/bin/env bash

# Use DMS to install DankGreeter. (https://danklinux.com/docs/dankgreeter/)
# For a manual installation, see https://danklinux.com/docs/dankgreeter/installation#manual-setup-all-distros
#
# This script assumes Yay, DMS, and Niri have already been installed, either manually or via home-manager.
# 
# ------------------------------------------
# -----------   IMPORTANT NOTE   -----------
# ------------------------------------------
#
# Niri must be installed system-wide for the greeter to find it.
# This means installing it via `pacman` in Arch or `configuration.nix` in NixOS.

set -euo pipefail

# Install greeter
echo "Installing dms-greeter-git from the AUR.."
yay -S greetd-dms-greeter-git niri --needed --noconfirm

# This will: 
# - Configure `/etc/greetd/config.toml` with the correct compositor command (Niri, Hyprland, etc).
# - Disable conflicting display managers (gdm, lightdm, sddm, etc).
# - Enable and start the greetd service.
echo "Enabling greeter.."
dms greeter enable

# This will
# - Add the current user to the `greeter` group if needed.
# - Set up ACL permissions on parent directories for greeter access.
# - Configure group permissions on DMS config directories.
# - Create symlinks to sync settings, wallpapers, and color themes.
#
# NOTE: We need to log out and log back in for group membership changes to take effect.
echo "Syncing greeter with DMS.."
dms greeter sync


# Here we configure the Niri session for the greeter.
echo "Configuring Niri for the greeter.."
sudo tee /etc/greetd/niri.kdl > /dev/null << 'EOF'
hotkey-overlay {
    skip-at-startup
}

environment {
    DMS_RUN_GREETER "1"
}

gestures {
  hot-corners {
    off
  }
}

output "HDMI-A-1" {
  off
}

output "DP-1" {
  mode "1920x1080@144.000"
  position x=4480 y=0
  scale 1
}

output "DP-2" {
  mode "1920x1080@60.000"
  position x=0 y=0
  scale 1
}

output "DP-3" {
  mode "2560x1440@155.000"
  position x=1920 y=0
  scale 1
  focus-at-startup
}
EOF

# Update the command in `/etc/greetd/config.toml to use this configuration
sudo tee /etc/greetd/config.toml > /dev/null << 'EOF'
[terminal]
vt = 1

[default_session]
command = "dms-greeter --command niri -C /etc/greetd/niri.kdl"

user = "greeter"
EOF

echo "Greeter installation completed!"