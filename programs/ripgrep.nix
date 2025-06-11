{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--hidden"
      "--glob=!.git"
      "--ignore-file=.gitignore"
    ];
  };
}
