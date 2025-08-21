#!/bin/bash
TARGET_WS="$1"
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r ".name")

if [ "$CURRENT_WS" != "$TARGET_WS" ]; then
    hyprctl dispatch workspace "$TARGET_WS"
fi
