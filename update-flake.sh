#!/usr/bin/env bash

set -euo pipefail
shopt -s failglob

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

is_git_dirty() {
	test -n "$(git status --porcelain)"
}

if is_git_dirty; then
	echo "Git is dirty. Commit or stash changes first."
	exit 1
fi

nix flake update

if is_git_dirty; then
	./switch.sh
	git add flake.lock
	git commit -m "Update flake.lock"
else
	echo "Flake already up-to-date"
fi
