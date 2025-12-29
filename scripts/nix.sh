#!/usr/bin/env bash

set -euo pipefail

if command -v nix > /dev/null; then
  echo "Nix is already installed!"
  return 2>/dev/null || exit
fi

sudo pacman -S nix --needed --noconfirm
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