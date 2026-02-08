{ config, pkgs, lib, llmPkgs, ... }:

{
  home = {
    packages = with pkgs; [
      entr
      jq
      nixpkgs-fmt
      shellcheck
      stylua
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      keyswitch
    ];

    sessionVariables = with pkgs.stdenv.hostPlatform; {
      LESS = "-Rc -+F";
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

    shellAliases = {
      # git
      gco = "git checkout";
      gsw = "git switch";
      gre = "git restore";
      gd = "git diff";
      gplog = "git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset\" --abbrev-commit --date=relative";
      gst = "git status";
      gwch = "git log -p --abbrev-commit --pretty=medium";

      # tmux
      tm = "tmux -2";
      tmrw = "tmux rename-window (basename (pwd))";

      # Fancy replacements for standard tools
      top = "btop";
      tree = "eza --tree";

      # Ruby
      be = "bundle exec";
      rspec = "rspec --format documentation";

      # Node
      npr = "npm run";

      # zoxide
      j = "z";
    };
  };

  imports = [
    ./programs/bat.nix
    ./programs/btop.nix
    ./programs/dircolors.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fd.nix
    ./programs/fish
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/konsole.nix
    ./programs/neovim
    ./programs/nix.nix
    ./programs/nixpkgs
    ./programs/nushell
    ./programs/opencode.nix
    ./programs/psql.nix
    ./programs/readline.nix
    ./programs/ripgrep.nix
    ./programs/sqlite.nix
    ./programs/stylua.nix
    ./programs/tmux.nix
    ./programs/zoxide.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
