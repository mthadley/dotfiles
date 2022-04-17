{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      entr
      htop
      jq
      nixpkgs-fmt
      ripgrep

      # Just used to verify home-manager setup
      hello
    ] ++ pkgs.lib.optionals (!pkgs.stdenv.isAarch64) [
      shellcheck
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      keyswitch
    ];

    sessionVariables = {
      EDITOR = "vim";
      LESS = "-c -+F";
      fish_greeting = "";
    } // pkgs.lib.optionalAttrs pkgs.hostPlatform.isLinux {
      # Fixes issues with locale in non-NixOS usage of nix
      #
      # See:
      # https://github.com/NixOS/nixpkgs/issues/6878
      # https://github.com/rycee/home-manager/issues/354
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };
  };

  imports =
    let
      # Trying to access lib here from the `pkgs` parameter
      # results in infinite recursion, as the final `pkgs` itself
      # actually depends on these imports. As a work-around, we can
      # explicitly import our own lib for use just in this expression.
      pkgs = (import <nixpkgs> { });
    in
    [
      ./programs/autojump.nix
      ./programs/bat.nix
      ./programs/direnv.nix
      ./programs/exa.nix
      ./programs/fish/default.nix
      ./programs/fzf.nix
      ./programs/git.nix
      ./programs/nix.nix
      ./programs/nixpkgs
      ./programs/tmux.nix
      ./programs/vim/default.nix
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      ./programs/konsole.nix
      ./programs/vim/vimwiki.nix
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
