{
  programs.readline = {
    enable = true;

    variables = {
      editing-mode = "vi";
      show-mode-in-prompt = true;
      vi-cmd-mode-string = "\"n \"";
      vi-ins-mode-string = "\"i \"";
    };
  };
}
