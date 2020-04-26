{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.ranger ];

    file.".config/ranger/rc.conf".text = ''
      set show_hidden true
    '';
  };
}
