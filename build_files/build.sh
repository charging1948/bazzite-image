#!/bin/bash

set -ouex pipefail

dnf5 -y copr enable bieszczaders/kernel-cachyos
dnf5 install -y kernel-cachyos kernel-cachyos-devel-matched
dnf5 -y copr disable bieszczaders/kernel-cachyos

dnf5 -y copr enable bieszczaders/kernel-cachyos-addons
dnf5 install -y libcap-ng libcap-ng-devel procps-ng procps-ng-devel
dnf5 install -y uksmd
dnf5 -y copr disable bieszczaders/kernel-cachyos-addons

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs packages from fedora repos
dnf5 install -y tmux stow go uv podman-docker podman-compose podman-tui podlet plasma-browser-integration dnf-plugins-core

# Use a COPR Example:
#
dnf5 -y copr enable lukenukem/asus-linux
dnf5 install -y asusctl supergfxctl
dnf5 -y copr disable lukenukem/asus-linux

systemctl enable supergfxd.service

dnf5 install -y asusctl-rog-gui

dnf5 -y copr enable codifryed/CoolerControl
dnf5 install -y coolercontrol liquidctl
dnf5 -y copr disable codifryed/CoolerControl
systemctl enable coolercontrold

# Use a COPR Example:
#
dnf5 -y copr enable agriffis/neovim-nightly
dnf5 install -y neovim
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable agriffis/neovim-nightly

#### Example for enabling a System Unit File

systemctl enable podman.socket
# systemctl enable ksmd.service

mkdir /nix
