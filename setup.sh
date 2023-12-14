#!/usr/bin/env bash
set -eou pipefail

function is_installed {
  command -v "$1" > /dev/null
}

if [ -z "${HOME_MANAGER_CONFIG}" ]; then
  echo "Error: HOME_MANAGER_CONFIG is not set."
  exit 1
fi

FLAKE_URI="path:.#homeConfigurations.${HOME_MANAGER_CONFIG}.activationPackage"

# Make sure curl is installed
if ! is_installed curl; then
  echo "Make sure curl is installed first!"
  exit 1
fi

# Install nix
if ! is_installed nix; then
  echo "Installing nix..."
  sh <(curl -L https://nixos.org/nix/install) --daemon

  if [ "$(uname)" = "Darwin" ]; then
    echo "Disabling spotlight for /nix..."
    sudo mdutil -i off /nix
  fi

  echo "Sourcing nix vars..."
  source /nix/var/nix/profiles/default//etc/profile.d/nix-daemon.sh
fi

# Install Home Manager
if ! is_installed home-manager; then
  echo "Installing Home Manager..."

  nix build --extra-experimental-features "nix-command flakes" --no-link "$FLAKE_URI"
  "$(nix --extra-experimental-features "nix-command flakes" path-info "${FLAKE_URI}")"/activate
fi

echo "Switching to new configuration..."
home-manager switch --flake "path:.#$HOME_MANAGER_CONFIG"

if ! echo "$SHELL" | grep fish > /dev/null; then
  echo "Setting fish as default shell..."

  FISH_SHELL_PATH=$(command -v fish)

  if ! grep "$FISH_SHELL_PATH" /etc/shells; then
    echo "Adding fish to /etc/shells..."
    echo "$FISH_SHELL_PATH"| sudo tee /etc/shells
  fi

  echo "Changing user shell..."
  if ! sudo chsh -s "$FISH_SHELL_PATH" "$USER"; then
    echo
    echo "You may need to edit /etc/pam.d/chsh and change the following line:"
    echo
    echo "- auth required pam_shells.so"
    echo "+ auth sufficient pam_shells.so"
    echo
    echo "Then try re-running this script again!"
    echo
  fi
fi
