{ config, pkgs, lib, llmPkgs, ... }:

{
  home = {
    packages = with pkgs; [
      entr
      jq
      nixpkgs-fmt
      llmPkgs.opencode
      shellcheck
      stylua
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      keyswitch
    ];

    sessionVariables = with pkgs.stdenv.hostPlatform; {
      LESS = "-c -+F";
    } // lib.optionalAttrs isLinux {
      # Fixes issues with locale in non-NixOS usage of nix
      #
      # See:
      # https://github.com/NixOS/nixpkgs/issues/6878
      # https://github.com/rycee/home-manager/issues/354
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    } // lib.optionalAttrs isDarwin {
      # Override the default agent on MacOS
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };
  };

  imports = [
    ./programs/autojump.nix
    ./programs/bat.nix
    ./programs/btop.nix
    ./programs/dircolors.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fd.nix
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
    ./programs/sqlite.nix
    ./programs/stylua.nix
    ./programs/tmux.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
