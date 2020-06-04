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

  base16-konsole = self.stdenv.mkDerivation {
    name = "base16-konsole";

    src = self.fetchFromGitHub {
      owner = "cskeeters";
      repo = "base16-konsole";
      rev = "b30e0b26e766cf8a3d12afb18ac2773f53af5a87";
      sha256 = "0a8pjah1nkimnj3b59mvfj53zmjd4252s7zb7drvv45ik4n4cjj9";
    };

    dontBuild = true;

    installPhase = ''
      source $stdenv/setup

      mkdir -p $out/share/konsole
      cp ./colorscheme/* $out/share/konsole
    '';
  };
}
