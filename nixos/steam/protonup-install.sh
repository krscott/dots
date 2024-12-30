#!/usr/bin/env bash

set -euo pipefail
shopt -s failglob

protonup -d "$HOME/.steam/root/compatibilitytools.d/"
protonup
