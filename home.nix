{ config, pkgs, ... }:

{

  imports = [
    ./programs/git.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
