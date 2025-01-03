#!/usr/bin/env bash

set -euo pipefail

# default: "appmenu:close"
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"

# default: false
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button "true"
