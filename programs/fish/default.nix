{ pkgs, ... }:

{
  xdg.configFile."fish/functions" = {
    source = ./functions;
  };

  home.sessionVariables = {
    fish_greeting = "";
    BASE_16_PATH = pkgs.base16;
  };

  programs.fish = {
    enable = true;

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
    };

    shellInit = builtins.readFile ./init.fish;
    interactiveShellInit = builtins.readFile ./config.fish;
  };
}
