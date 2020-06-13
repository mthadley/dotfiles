{ stdenv, ... }:

stdenv.mkDerivation {
  name = "similar-sort";

  buildInputs = [];

  src = ./.;
}
