{ stdenv, haskellPackages, ...}:

stdenv.mkDerivation {
  name = "similar-sort";

  buildInputs = [
    (haskellPackages.ghcWithPackages (haskellPkgs: with haskellPkgs; [ edit-distance-linear ]))
  ];

  buildPhase = ''
    ghc -O2 -Wall -Werror similar-sort.hs
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp similar-sort $out/bin
  '';

  src = ./.;
}
