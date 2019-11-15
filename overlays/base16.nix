self: super:

{
  base16 = self.stdenv.mkDerivation {
    name = "base16";

    src = fetchGit {
      url = "git@github.com:chriskempson/base16-shell.git";
      ref = "master";
    };

    dontBuild = true;

    installPhase = ''
      source $stdenv/setup

      mkdir -p $out/share/base16
      cp -R ./* $out/share/base16
    '';
  };
}
