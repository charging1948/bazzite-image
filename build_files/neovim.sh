#!/bin/bash

set -ouex pipefail


### Install packages

# Use a COPR Example:
#
dnf5 -y copr enable agriffis/neovim-nightly
dnf5 install -y neovim
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable agriffis/neovim-nightly
