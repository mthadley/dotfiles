{ ... }:

{
  programs.fzf = {
    enable = true;

    defaultCommand = "rg --files";
    defaultOptions = ["--color=16"];
  };
}
