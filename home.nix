{ pkgs, lib, ... }:

{
  home = {
    packages = with pkgs; [
      entr
      htop
      jq
      nixpkgs-fmt

      # Just used to verify home-manager setup
      hello
    ] ++ lib.optionals (!pkgs.stdenv.isAarch64) [
      shellcheck
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      keyswitch
    ];

    sessionVariables = {
      LESS = "-c -+F";
    } // lib.optionalAttrs pkgs.hostPlatform.isLinux {
      # Fixes issues with locale in non-NixOS usage of nix
      #
      # See:
      # https://github.com/NixOS/nixpkgs/issues/6878
      # https://github.com/rycee/home-manager/issues/354
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };
  };

  imports =
    [
      ./programs/autojump.nix
      ./programs/bat.nix
      ./programs/direnv.nix
      ./programs/exa.nix
      ./programs/fish/default.nix
      ./programs/fzf.nix
      ./programs/git.nix
      ./programs/konsole.nix
      ./programs/neovim/default.nix
      ./programs/nix.nix
      ./programs/nixpkgs
      ./programs/psql.nix
      ./programs/readline.nix
      ./programs/ripgrep.nix
      ./programs/tmux.nix
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
