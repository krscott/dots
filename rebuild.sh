#!/usr/bin/env bash

set -euo pipefail

sudo nixos-rebuild switch --flake .#"$(hostname)" --impure
