{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "similar-sort";
  version = "1.0.0";

  src = ./.;

  cargoSha256 = "113di4cgxl60689rmii9q36s3iz4w9gnr0j901bqqspgq2wfzxj6";

  verifyCargoDeps = true;

  meta = with pkgs.stdenv.lib; {
    description = "Sorts stdin by how similar to the given string";
    platforms = platforms.all;
  };
}
