ARG UBUNTU_VERSION=26.04
FROM --platform=linux/amd64 ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Dhaka
ENV HOME=/home/desktop
ENV DISPLAY=:1
ENV VNC_GEOMETRY=1366x768
ENV VNC_DEPTH=24

RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 xfce4-goodies \
    tigervnc-standalone-server \
    novnc websockify \
    dbus-x11 x11-xserver-utils x11-apps xterm \
    sudo curl wget ca-certificates gnupg \
    fonts-dejavu-core tzdata \
    && rm -rf /var/lib/apt/lists/*

# Google Chrome
RUN wget -qO /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get update \
    && apt-get install -y /tmp/chrome.deb || apt-get -f install -y \
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
exec startxfce4
EOF
RUN chmod +x /home/desktop/.vnc/xstartup

RUN cat > /home/desktop/.config/autostart/chrome.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Google Chrome
Exec=google-chrome-stable --no-sandbox --disable-dev-shm-usage --start-maximized
X-GNOME-Autostart-enabled=true
EOF

COPY --chown=desktop:desktop start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5901
EXPOSE 6080

CMD ["/usr/local/bin/start.sh"]
