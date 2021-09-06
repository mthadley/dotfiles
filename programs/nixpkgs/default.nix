{
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  nixpkgs = {
    config = import ./nixpkgs-config.nix;

    overlays =
      let
        overlayDir = ../../overlays;
      in
      builtins.map
        (n: import (overlayDir + "/${n}"))
        (builtins.attrNames (builtins.readDir overlayDir));
  };
}
