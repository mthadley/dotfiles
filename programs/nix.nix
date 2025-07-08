{
  home.file.nixConfig = {
    text = ''
      experimental-features = nix-command flakes
    '';
    target = ".config/nix/nix.conf";
  };
}
