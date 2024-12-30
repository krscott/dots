#!/usr/bin/env bash

set -euo pipefail
shopt -s failglob

#SYSTEM=$(nix eval --impure --raw --expr 'builtins.currentSystem')

export NIXPKGS_ALLOW_UNFREE=1
# Note: --impure required by nixGLNvidia
nix run nixpkgs#home-manager -- switch --flake ."#$USER@$HOSTNAME" --impure "$@"

# Extract dotfiles to Windows
if command -v sync-dots >/dev/null; then
	sync-dots
fi
