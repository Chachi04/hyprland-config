#!/bin/bash

CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.name')
WS=$1
WORKSPACE_WIHT_WS=$(hyprctl workspaces -j | jq -r '.[] | select(.name=="'"$WS"'") | .monitor')
CURRENT_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')

hyprctl dispatch moveworkspacetomonitor "$CURRENT_WORKSPACE" "$WORKSPACE_WIHT_WS"
hyprctl dispatch moveworkspacetomonitor "$WS" "$CURRENT_MONITOR"
~/.config/hypr/scripts/movetows.sh "$WS"
