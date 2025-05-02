#!/bin/bash

set -ouex pipefail


### Set important stuff (needed for nix)

cat >/etc/ostree/prepare-root.conf <<'EOL'
[composefs]
enabled = yes
[sysroot]
readonly = true
[root]
transient = true
EOL


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux stow go uv

# Use a COPR Example:
#
dnf5 -y copr enable agriffis/neovim-nightly
dnf5 -y install neovim
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable agriffis/neovim-nightly

#### Example for enabling a System Unit File

systemctl enable podman.socket
mkdir /nix

# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install ostree --no-confirm --no-start-daemon
