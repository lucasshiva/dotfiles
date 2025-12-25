#!/usr/bin/env bash

sudo pacman -S docker docker-compose --needed --noconfirm
systemctl enable --now docker.service
sudo usermod -aG docker $USER
