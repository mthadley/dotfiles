self: super:

{
  base16 = self.stdenv.mkDerivation {
    name = "base16";

    src = self.fetchFromGitHub {
      owner = "chriskempson";
      repo = "base16-shell";
      rev = "ce8e1e540367ea83cc3e01eec7b2a11783b3f9e1";
      sha256 = "1yj36k64zz65lxh28bb5rb5skwlinixxz6qwkwaf845ajvm45j1q";
    };

    dontBuild = true;

    installPhase = ''
      source $stdenv/setup

      mkdir -p $out/share/base16
      cp -R ./* $out/share/base16
    '';
  };
}
