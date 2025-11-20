{
  home.file.".config/nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
