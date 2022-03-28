{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    config = {
      skip_dotenv = true;
    };
  };
}
