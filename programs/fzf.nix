{ pkgs, ... }:

let
  defaultFilesCommand = "${pkgs.fd}/bin/fd";
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
