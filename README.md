# 🚀 Ubuntu Desktop for Railway

A complete Ubuntu Desktop environment for Railway with XFCE, TigerVNC, noVNC, and Google Chrome.

---

# 📖 Overview

This project allows you to deploy a complete Linux Desktop environment on Railway using Docker.

The desktop can be accessed directly from any web browser using noVNC or from any VNC client.

It is designed to be lightweight, simple, and easy to deploy.

---

# ✨ Features

✅ Ubuntu Desktop

✅ XFCE Desktop Environment

✅ TigerVNC Server

✅ noVNC Browser Access

✅ Google Chrome Browser

✅ Websockify

✅ Docker Ready

✅ Railway Compatible

✅ Lightweight Desktop

✅ Fast Startup

✅ Easy Configuration

---

# 📦 Included Software

• Ubuntu Linux

• XFCE4 Desktop

• TigerVNC

• noVNC

• Websockify

• Google Chrome

• xterm

• curl

• wget

• git

• vim

• sudo

• net-tools

---

# 🌐 Ports

| Port | Description |
|-------|-------------|
| 6080 | noVNC Web Desktop |
| 5901 | VNC Server |

---

# 🔑 Environment Variables

Before deployment, add the following Railway Variables.

| Variable | Description |
|----------|-------------|
| VNC_PASSWORD | Password for VNC Login |

Example

VNC_PASSWORD=123456

---

# 🚀 Deployment

## Step 1

Fork or Clone this repository.

## Step 2

Create a new Railway Project.

## Step 3

Connect your GitHub Repository.

## Step 4

Deploy using Dockerfile.

## Step 5

Wait until Build is completed.

## Step 6

Open Railway Public Domain.

## Step 7

Login using your VNC Password.

---

# 🖥 Desktop Resolution

Default

1366×768

You can change the resolution by editing

VNC_GEOMETRY

Example

1920x1080

1600x900

1366x768

1024x768

---

# 🔒 Security

Never expose your VNC password publicly.

Always use a strong password.

---

# 📂 Repository Structure

OneClickDesktop/

Dockerfile

start.sh

railway.toml

README.md

.gitignore

---

# 📋 Requirements

Railway Account

GitHub Account

Modern Web Browser

Internet Connection

---

# ⚡ Performance

Recommended RAM

2 GB+

Recommended CPU

2 vCPU+

---

# 🛠 Built With

Ubuntu

Docker

XFCE

TigerVNC

noVNC

Google Chrome

Railway

---

# 📜 License

MIT License

---

# ❤️ Credits

Built for Railway Desktop Deployment.

Ubuntu © Canonical

XFCE Desktop

TigerVNC

noVNC

Docker

Railway

---

# ⭐ Support

If you like this project, don't forget to give it a ⭐ on GitHub.

Happy Deploying!
