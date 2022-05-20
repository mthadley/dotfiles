{ pkgs, ... }:

let
  ripgrepConfigPath = ".config/ripgrep/rgrc";
in
{
  home = {
    packages = [ pkgs.ripgrep ];

    sessionVariables = {
      RIPGREP_CONFIG_PATH = "$HOME/" + ripgrepConfigPath;
    };

    file.ripgrepConfig = {
      text = ''
        --hidden
        --glob=!.git/*
      '';
      target = ripgrepConfigPath;
    };
  };
}
