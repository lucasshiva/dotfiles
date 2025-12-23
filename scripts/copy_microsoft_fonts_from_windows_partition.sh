#!/usr/bin/env bash

# Exit the script immediately if any command fails.
set -e

# Helps with globbing, not sure how.
shopt -s nullglob

WINDOWS_PARTITION="/mnt/windows"
DESTINATION_DIR="/usr/local/share/fonts/WindowsFonts"

if [ -d "$DESTINATION_DIR" ]; then
  echo "Error: $DESTINATION_DIR already exists."
  echo "Aborting to avoid overwriting files.."
  exit 1
fi

mkdir -p "$DESTINATION_DIR"
cp "$WINDOWS_PARTITION/Windows/Fonts/"* "$DESTINATION_DIR/"
chmod 644 "$DESTINATION_DIR/"*

if command -v fc-cache >/dev/null 2>&1; then
  fc-cache --force
fi

if command -v fc-cache-32 >/dev/null 2>&1; then
  fc-cache-32 --force
fi

