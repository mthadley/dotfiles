{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      autojump
      ripgrep
      jq
      htop
      shellcheck
      ormolu
    ];

    sessionVariables = {
      EDITOR = "vim";
      fish_greeting = "";
    };
  };

  imports = [
    ./programs/direnv.nix
    ./programs/fish/default.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/vim/neovim.nix
  ];

  nixpkgs.overlays = builtins.map
    (n: import (./overlays + "/${n}"))
    (builtins.attrNames (builtins.readDir ./overlays));

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
