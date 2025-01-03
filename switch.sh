#!/usr/bin/env bash

set -euo pipefail
shopt -s failglob

#SYSTEM=$(nix eval --impure --raw --expr 'builtins.currentSystem')
HOSTNAME=${HOSTNAME:-$(hostname)}

if grep '^NAME=NixOS$' /etc/os-release >/dev/null; then
    # NixOS host

    mkdir -p "hosts/$HOSTNAME"
    cp "/etc/nixos/hardware-configuration.nix" "hosts/$HOSTNAME/hardware-configuration.nix"

    sudo nixos-rebuild switch --flake ."#$HOSTNAME" "$@"

else
    # non-NixOS host with home-manager

    export NIXPKGS_ALLOW_UNFREE=1
    # Note: --impure required by nixGLNvidia
    nix run "nixpkgs#home-manager" -- switch --flake ."#$USER@$HOSTNAME" --impure "$@"

    # Extract dotfiles to Windows
    if command -v sync-dots >/dev/null; then
        sync-dots
    fi
fi

if [ "${TERM_PROGRAM:-}" = "tmux" ]; then
    tmux source-file ~/.config/tmux/tmux.conf
fi

if command -v krs_flatpak_install >/dev/null; then
    krs_flatpak_install
fi
