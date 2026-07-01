#!/usr/bin/env bash
set -euo pipefail

export HOME=/home/desktop
export DISPLAY=:1
export VNC_GEOMETRY="${VNC_GEOMETRY:-1366x768}"
export VNC_DEPTH="${VNC_DEPTH:-24}"

mkdir -p "$HOME/.vnc"

# VNC password
VNC_PASS="${VNC_PASSWORD:-password}"
printf '%s\n%s\n\n' "$VNC_PASS" "$VNC_PASS" | vncpasswd

# Clean any stale lock/pid files
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1 "$HOME/.vnc/"*.pid 2>/dev/null || true

# Start VNC
vncserver :1 -geometry "$VNC_GEOMETRY" -depth "$VNC_DEPTH" -localhost no

# Start noVNC
exec websockify --web=/usr/share/novnc/ 6080 localhost:5901
