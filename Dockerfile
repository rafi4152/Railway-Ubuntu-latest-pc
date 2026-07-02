FROM --platform=linux/amd64 ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive 
TZ=Asia/Dhaka 
HOME=/home/desktop 
DISPLAY=:1 
VNC_GEOMETRY=1366x768 
VNC_DEPTH=24

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends 
xfce4 xfce4-goodies 
tigervnc-standalone-server tigervnc-common 
novnc websockify 
dbus-x11 x11-xserver-utils x11-apps xterm 
sudo curl wget ca-certificates gnupg 
fonts-dejavu-core tzdata 
fontconfig xdg-utils 
&& rm -rf /var/lib/apt/lists/*

Google Chrome

RUN set -eux; 
wget -qO /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; 
apt-get update; 
apt-get install -y --no-install-recommends /tmp/chrome.deb; 
rm -f /tmp/chrome.deb; 
rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash desktop 
&& echo "desktop ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/desktop 
&& chmod 0440 /etc/sudoers.d/desktop

USER desktop
WORKDIR /home/desktop

RUN mkdir -p /home/desktop/.vnc /home/desktop/.config/autostart 
&& printf '%s\n' 
'#!/bin/sh' 
'unset SESSION_MANAGER' 
'unset DBUS_SESSION_BUS_ADDRESS' 
'exec startxfce4' 
> /home/desktop/.vnc/xstartup 
&& chmod +x /home/desktop/.vnc/xstartup 
&& printf '%s\n' 
'[Desktop Entry]' 
'Type=Application' 
'Name=Google Chrome' 
'Exec=google-chrome-stable --no-sandbox --disable-dev-shm-usage --start-maximized' 
'X-GNOME-Autostart-enabled=true' 
> /home/desktop/.config/autostart/chrome.desktop

COPY --chown=desktop:desktop start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5901
EXPOSE 6080

CMD ["/usr/local/bin/start.sh"]
