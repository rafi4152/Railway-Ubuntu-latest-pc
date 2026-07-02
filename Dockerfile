ARG UBUNTU_VERSION=26.04
FROM --platform=linux/amd64 ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Dhaka
ENV HOME=/home/desktop
ENV DISPLAY=:1
ENV VNC_GEOMETRY=1360x768
ENV VNC_DEPTH=24
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 xfce4-goodies \
    gnome-session gnome-session-flashback gnome-flashback \
    gnome-terminal nautilus gnome-settings-daemon \
    tigervnc-standalone-server \
    novnc websockify \
    dbus-x11 dbus-user-session \
    x11-xserver-utils x11-apps xterm xauth \
    sudo curl wget ca-certificates gnupg \
    fonts-dejavu-core fonts-liberation locales tzdata \
    adwaita-icon-theme hicolor-icon-theme \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Google Chrome
RUN wget -qO /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get update \
    && apt-get install -y /tmp/chrome.deb \
    && rm -f /tmp/chrome.deb \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash desktop \
    && echo "desktop ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/desktop \
    && chmod 0440 /etc/sudoers.d/desktop

USER desktop
WORKDIR /home/desktop

RUN mkdir -p /home/desktop/.vnc /home/desktop/.config/autostart

RUN cat > /home/desktop/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XDG_CURRENT_DESKTOP=GNOME
export XDG_SESSION_TYPE=x11
export GNOME_SHELL_SESSION_MODE=classic
exec dbus-run-session gnome-session --session=gnome-flashback-metacity
EOF
RUN chmod +x /home/desktop/.vnc/xstartup

RUN cat > /home/desktop/.config/autostart/chrome.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Google Chrome
Exec=google-chrome-stable --no-sandbox --disable-dev-shm-usage --start-maximized
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

COPY --chown=desktop:desktop start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5901
EXPOSE 6080

CMD ["/usr/local/bin/start.sh"]
