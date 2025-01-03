#!/usr/bin/env bash
#
# On host machine:
# ```
# ln -s "$PWD/my-startup.desktop" ~/.config/autostart/
# ```

set -euo pipefail
shopt -s failglob

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

isdef() {
	type "$1" >/dev/null 2>&1
}

(
	date

	echo "=== Setup Google Drive ==="
	isdef rclone || ./rclone-install.sh
	# Configure gdrive manually: https://rclone.org/drive/
	isdef rclone && [[ -d "$HOME/gdrive" ]] && rclone mount gdrive: "$HOME/gdrive" --daemon

	echo "=== Fix touch ==="
	distrobox enter ubuntu-nix -- bash -ic './fix-touch.sh'
) >startup.log 2>&1
