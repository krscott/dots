#!/usr/bin/env bash

# exit when any command fails
set -euo pipefail
shopt -s failglob

PRIMARY="DP-0"
SECONDARY="HDMI-0"
SECONDARY_WIDTH=1024

if xrandr --listactivemonitors | grep "$SECONDARY" >/dev/null 2>&1; then
	xrandr --output $SECONDARY --off
else
	# Enable secondary monitor centered below primary

	# Get the resolution of the primary monitor
	PRIMARY_RES=$(xrandr | grep "^$PRIMARY" | cut -d' ' -f4)
	PRIMARY_WIDTH=$(echo "$PRIMARY_RES" | cut -dx -f1)
	PRIMARY_HEIGHT=$(echo "$PRIMARY_RES" | cut -dx -f2 | cut -d+ -f1)

	# Calculate the offset to center the secondary monitor
	OFFSET=$(((PRIMARY_WIDTH - SECONDARY_WIDTH) / 2))
	OFFSET=${OFFSET#-} # Remove any negative sign

	xrandr --output $SECONDARY --auto --pos "${OFFSET}x${PRIMARY_HEIGHT}"
fi
