#!/usr/bin/env bash
set -eou pipefail

function is_installed {
  command -v $1 > /dev/null
}

# Install nix
if is_installed nix; then
  echo "Nix is installed!"
else
  echo "Installing nix..."
  curl https://nixos.org/nix/install | sh
fi

# Install Home Manager
if is_installed home-manager; then
  echo "Home Manager is installed!"
else
  echo "Installing Home Manager..."
  echo "Assuming nixpkgs-unstable and using home-manager@master..."

  nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
  nix-channel --update

  echo "Setting up first home-manager generation..."
  nix-shell '<home-manager>' -A install
fi

# Link home manager configuration
ln -sFf $(realpath home.nix) ~/.config/nixpkgs/home.nix

# Enable configuration
echo "Switching to new configuration..."
home-manager switch
