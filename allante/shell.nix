{ pkgs ? import <nixpkgs> {} }:

let
  wrappedDoctl = pkgs.writeScriptBin "doctl" ''
    #!${pkgs.runtimeShell}
    ${pkgs.doctl}/bin/doctl -t $DIGITALOCEAN_TOKEN $@
  '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    terraform
    wrappedDoctl
  ];
}
