#!/usr/bin/env bash

# exit when any command fails
set -euo pipefail
shopt -s failglob

echo "Installing rclone"

tmp_dir=$(mktemp -d 2>/dev/null)
cd "$tmp_dir"

download_link="https://downloads.rclone.org/rclone-current-linux-amd64.zip"
curl -OfsS "$download_link"

rclone_zip="rclone-current-linux-amd64.zip"
unzip_dir="tmp_unzip_dir_for_rclone"
unzip -a "$rclone_zip" -d "$unzip_dir"

cd $unzip_dir/*

install_dir=~/bin
mkdir -p "$install_dir"
cp rclone "$install_dir"

rm -rf "$tmp_dir"
echo "rclone installed in $install_dir"

