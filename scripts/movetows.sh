#!/bin/bash
#
# # Workspace number to switch to is passed as first argument
# ws_num=$1
#
# # Get cursor position
# cursor_pos=$(hyprctl cursorpos)
# cursor_x=$(echo $cursor_pos | awk -F'[, ]' '{print $2}')
# cursor_y=$(echo $cursor_pos | awk -F'[, ]' '{print $3}')
#
# # Get monitors info and determine monitor under cursor
# monitor_id=""
# while read -r line; do
#     if [[ $line == Monitor* ]]; then
#         # Example line: Monitor: DP-2, 1920x1080+0+0
#         current_monitor=$(echo $line | awk '{print $2}' | tr -d ',')
#     fi
#     if [[ $line == *" Geometry:"* ]]; then
#         # Example geometry line: Geometry: 1920x1080+0+0
#         geom=$(echo $line | awk '{print $2}')
#         width=$(echo $geom | cut -d'x' -f1)
#         rest=$(echo $geom | cut -d'x' -f2)
#         height=$(echo $rest | cut -d'+' -f1)
#         pos_x=$(echo $rest | cut -d'+' -f2)
#         pos_y=$(echo $rest | cut -d'+' -f3)
#
#         # Check if cursor is inside this monitor
#         if (( cursor_x >= pos_x && cursor_x < pos_x + width && cursor_y >= pos_y && cursor_y < pos_y + height )); then
#             monitor_id=$current_monitor
#             break
#         fi
#     fi
# done < <(hyprctl monitors)
#
# # If no monitor found, fallback to focused monitor
# if [ -z "$monitor_id" ]; then
#     echo "FALLBACK"
#     monitor_id=$(hyprctl activewindow | grep Monitor | awk '{print $2}')
# fi
#
# # Dispatch workspace on monitor under cursor
# hyprctl dispatch workspace $ws_num, $monitor_id

TARGET_WS="$1"
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r ".name")

# Get monitor under cursor
MONITOR=$(hyprctl monitors | grep -B 1 "$(hyprctl cursor)" | head -n1 | tr -d ' ' | cut -d':' -f2)

if [ "$CURRENT_WS" != "$TARGET_WS" ]; then
    hyprctl dispatch workspace "$TARGET_WS"
fi
