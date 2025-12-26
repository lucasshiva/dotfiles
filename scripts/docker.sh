#!/usr/bin/env bash

# Using `docker-compose-bin` from the AUR because it reports the version correctly.
yay -S docker docker-compose-bin --needed --noconfirm
systemctl enable --now docker.service
sudo usermod -aG docker $USER
echo "Docker installed! You might need to logout or reboot."