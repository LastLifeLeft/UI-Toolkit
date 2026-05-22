#!/bin/bash
export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
cd /mnt/d/Documents/GitHub/UI-Toolkit/Examples
# Feed Enter to skip the final pause.
printf "\n" | timeout 5 ./_phase3_cleanup_test 2>&1
echo "exit=$?"
