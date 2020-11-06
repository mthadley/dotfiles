{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      entr
      exa
      htop
      jq
      ripgrep
      shellcheck

      # Just used to verify home-manager setup
      hello
    ];

    sessionVariables = {
      EDITOR = "vim";
      LESS = "-c -+F";
      fish_greeting = "";
    } // pkgs.stdenv.lib.optionalAttrs pkgs.stdenv.isLinux {
      # Fixes issues with locale in non-NixOS usage of nix
      #
      # See:
      # https://github.com/NixOS/nixpkgs/issues/6878
      # https://github.com/rycee/home-manager/issues/354
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };
  };

  imports = let
    # Trying to access stdenv here from the `pkgs` parameter
    # results in infinite recursion, as the final `pkgs` itself
    # actually depends on these imports. As a work-around, we can
    # explicitly import our own stdenv for use just in this expression.
    stdenv = (import <nixpkgs> {}).stdenv;
  in [
    ./programs/autojump.nix
    ./programs/bat.nix
    ./programs/direnv.nix
    ./programs/fish/default.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/vim/default.nix
  ] ++ stdenv.lib.optionals stdenv.isLinux [
    ./programs/konsole.nix
  ];

  nixpkgs.overlays = builtins.map
    (n: import (./overlays + "/${n}"))
    (builtins.attrNames (builtins.readDir ./overlays));

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
