self: super:

let
  src = self.fetchFromGitHub {
    owner = "mthadley";
    repo = "keyswitch";
    rev = "4c8f2aac936df02f339067576b7a3a39fe1a1f8e";
    sha256 = "0v5b2zzx3gdip9h0f3gd36ixg02hb19hfhbih7j80czq1ki0mrqv";
  };
in
{
  keyswitch = import src { pkgs = self; };
}
