#!/usr/bin/env bash

set -euo pipefail
shopt -s failglob

#SYSTEM=$(nix eval --impure --raw --expr 'builtins.currentSystem')

if grep '^NAME=NixOS$' /etc/os-release >/dev/null; then
	# NixOS host

	sudo nixos-rebuild switch --flake .#"$(hostname)" --impure

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
