{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cargo
    hyperfine
  ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
    libiconv
  ];
}
