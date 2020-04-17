{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      autojump
      exa
      htop
      jq
      ranger
      ripgrep
      shellcheck

      # Just used to verify home-manager setup
      hello
    ];

    sessionVariables = {
      EDITOR = "vim";
      fish_greeting = "";
    };
  };

  imports = [
    ./programs/bat.nix
    ./programs/direnv.nix
    ./programs/fish/default.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/vim/default.nix
  ];

  nixpkgs.overlays = builtins.map
    (n: import (./overlays + "/${n}"))
    (builtins.attrNames (builtins.readDir ./overlays));

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
