{ pkgs, ... }:

let
  defaultFilesCommand = "${pkgs.ripgrep}/bin/rg --files";
in
{
  programs.fzf = {
    enable = true;

    defaultCommand = defaultFilesCommand;
    fileWidgetCommand = defaultFilesCommand;

    defaultOptions = [ "--color=16" ];

    enableFishIntegration = true;
  };
}
