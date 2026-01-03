{ pkgs, ... }:

let
  defaultFilesCommand = "${pkgs.fd}/bin/fd";
in
{
  programs.fzf = {
    enable = true;

    defaultCommand = defaultFilesCommand;
    fileWidgetCommand = defaultFilesCommand;

    # Some suble tweaks to align with my `base16-ocean` preference. Actual
    # values were pulled from here:
    #
    #   https://github.com/RRethy/base16-nvim/blob/e6b3b10263288096653c3cfbcb144790874ef1a7/lua/colors/ocean.lua
    #
    defaultOptions = [ "--color=16,pointer:#ebcb8b,bg+:#343d46" ];

    enableFishIntegration = true;
  };
}
