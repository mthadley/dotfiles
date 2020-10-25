{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      autojump
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

  imports = [
    ./programs/autojump.nix
    ./programs/bat.nix
    ./programs/direnv.nix
    ./programs/fish/default.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/konsole.nix
    ./programs/tmux.nix
    ./programs/vim/default.nix
  ];

  nixpkgs.overlays = builtins.map
    (n: import (./overlays + "/${n}"))
    (builtins.attrNames (builtins.readDir ./overlays));

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
