{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      autojump
      ripgrep
    ];

    sessionVariables = {
      EDITOR = "vim";
      fish_greeting = "";
      hadley = "michael";
    };
  };

  imports = [
    ./programs/git.nix
    ./programs/fish/default.nix
    ./programs/direnv.nix
    ./programs/fzf.nix
    ./programs/tmux.nix
  ];

  nixpkgs.overlays = builtins.map
    (n: import (./overlays + "/${n}"))
    (builtins.attrNames (builtins.readDir ./overlays));

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
