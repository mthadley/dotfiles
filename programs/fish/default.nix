{ pkgs, ... }:

{
  home.file.fishFunctions = {
    source = ./functions;
    target = ".config/fish/functions";
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
      gwch = "git whatchanged -p --abbrev-commit --pretty=medium";

      # misc
      be = "bundle exec";
      npr = "npm run";
      rspec = "rspec --format documentation";
      tree = "eza --tree";

      # tmux
      tm = "tmux -2";
      tmrw = "tmux rename-window (basename (pwd))";
    };

    shellInit = builtins.readFile ./init.fish;
    interactiveShellInit = builtins.readFile ./config.fish;
  };
}
