#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs packages from fedora repos
dnf5 install -y podman-docker podman-compose podman-tui podlet plasma-browser-integration dnf-plugins-core

# Use a COPR Example:
#
dnf5 -y copr enable lukenukem/asus-linux
dnf5 install -y asusctl supergfxctl
dnf5 -y copr disable lukenukem/asus-linux

systemctl enable supergfxd.service

dnf5 install -y asusctl-rog-gui

#### Example for enabling a System Unit File

systemctl enable podman.socket
# systemctl enable ksmd.service

mkdir /nix
