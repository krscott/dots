#!/usr/bin/env bash

set -euo pipefail
shopt -s failglob

sudo nixos-rebuild switch --flake .#"$(hostname)" --impure
