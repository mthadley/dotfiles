#!/usr/bin/env bash
set -eou pipefail

function is_installed {
  command -v "$1" > /dev/null
}

# Enable debug mode on CI
if [ -n "${GITHUB_WORKFLOW:-}" ]; then
  set -x
fi

# Make sure curl is installed
if ! is_installed curl; then
  echo "Make sure curl is installed first!"
  exit 1
fi

# Install nix
if is_installed nix; then
  echo "Nix is installed!"
else
  echo "Installing nix..."
  sh <(curl -L https://nixos.org/nix/install)

  if [ "$(uname)" = "Darwin" ] && [ ! -z "$CI" ]; then
    echo "Disabling spotlight for /nix..."
    sudo mdutil -i off /nix
  fi

  echo "Sourcing nix profile vars..."
  # shellcheck disable=SC1090
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Install Home Manager
if is_installed home-manager; then
  echo "Home Manager is installed!"
else
  echo "Installing Home Manager..."
  echo "Assuming nixpkgs-unstable and using home-manager@master..."

  nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
  nix-channel --update

  # Make sure nix picks up the new channel
  export NIX_PATH=$HOME/.nix-defexpr/channels

  echo "Setting up first home-manager generation..."
  nix-shell '<home-manager>' -A install
fi

# Link home manager configuration
ln -sf "$(pwd)/home.nix" ~/.config/nixpkgs/home.nix

# Enable configuration
echo "Switching to new configuration..."
home-manager switch

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
