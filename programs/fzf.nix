{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;

    defaultCommand = "${pkgs.ripgrep}/bin/rg --files";
    defaultOptions = [ "--color=16" ];
  };
}
