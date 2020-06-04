{ pkgs, ... }:

{
  home.file.konsoleColorSchemes = {
    source = "${pkgs.base16-konsole}/share/konsole";
    target = ".local/share/konsole";
    recursive = true;
  };
}
