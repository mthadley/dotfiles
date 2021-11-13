{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cargo
    hyperfine
    rustfmt
  ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
    libiconv
  ];
}
