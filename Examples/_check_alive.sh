#!/bin/bash
# Launch a UITK binary, check it's still alive after 1 second, then terminate.
# Usage: _check_alive.sh <binary>
export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
cd /mnt/d/Documents/GitHub/UI-Toolkit/Examples
"./$1" &
PID=$!
sleep 1
if kill -0 "$PID" 2>/dev/null; then
  echo "ALIVE_AT_1S $1 pid=$PID"
  ps -p "$PID" -o pid,stat,comm 2>&1 | tail -1
  kill -TERM "$PID" 2>/dev/null
  sleep 0.3
  kill -KILL "$PID" 2>/dev/null
else
  echo "DEAD_BEFORE_1S $1"
fi
wait "$PID" 2>/dev/null
