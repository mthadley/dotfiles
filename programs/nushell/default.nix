{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;

    settings = {
      show_banner = false;
      edit_mode = "vi";
    };
  };
}
