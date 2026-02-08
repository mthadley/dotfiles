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

    shellInit = builtins.readFile ./init.fish;
    interactiveShellInit = builtins.readFile ./config.fish;
  };
}
