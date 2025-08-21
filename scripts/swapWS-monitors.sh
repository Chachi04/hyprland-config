#!/bin/bash

WS1=1
WS2=8

# Get window IDs under a given workspace from hyprctl clients
get_windows_in_ws() {
  local ws=$1
  hyprctl clients | awk -v ws="workspace: $ws " '
    /^Window/ {win=$2}
    $1 == "workspace:" && $0 ~ ws {print win}
  '
}

# Move windows from one workspace to another
move_windows_to_ws() {
  local ws=$1
  shift
  local wins=("$@")
  for win_id in "${wins[@]}"; do
    # Move window to target workspace
    hyprctl dispatch movetoworkspace $ws activewindow:$win_id
    # Note: No direct per-window monitor move command in hyprctl, 
    # windows follow workspace on their monitor assignment
  done
}

# Get windows currently in workspace 1 and 8
wins_ws1=($(get_windows_in_ws $WS1))
wins_ws2=($(get_windows_in_ws $WS2))

# Move windows in workspace 1 to workspace 8
move_windows_to_ws $WS2 "${wins_ws1[@]}"

# Move windows in workspace 8 to workspace 1
move_windows_to_ws $WS1 "${wins_ws2[@]}"

# Focus workspace 8 (now with windows from workspace 1)
hyprctl dispatch workspace $WS2
