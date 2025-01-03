#!/usr/bin/env bash

set -euo pipefail
shopt -s failglob

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

read -rp "Hostname: " HOSTNAME
echo "Temporarily set HOSTNAME=$HOSTNAME"
HOSTDIR="hosts/$HOSTNAME"
mkdir "$HOSTDIR"
cp /etc/nixos/*.nix "$HOSTDIR"
sed -i "s/networking\.hostName = \".*\";/networking.hostName = \"$HOSTNAME\";/g" "$HOSTDIR/configuration.nix"

sed -i "/nixosConfigurations = {/a\ \ \ \ \ \ \"$HOSTNAME\" = mkNixos ./$HOSTDIR/configuration.nix;" flake.nix

git add .

export HOSTNAME
./switch.sh
