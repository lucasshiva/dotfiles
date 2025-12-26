#!/usr/bin/env bash

set -euo pipefail

sudo pacman -S nix
systemctl enable --now nix-daemon.service

sudo tee /etc/nix/nix.conf > /dev/null << 'EOF'
#
# https://nixos.org/manual/nix/stable/#sec-conf-file
#

# Unix group containing the Nix build user accounts
build-users-group = nixbld

max-jobs = auto
experimental-features = nix-command flakes
trusted-users = root lucas
EOF

echo "Installation completed!"