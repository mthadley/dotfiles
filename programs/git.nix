{ ... }:

{
  programs.git = {
    enable = true;

    userEmail = "mikethadley@gmail.com";
    userName = "Michael Hadley";

    ignores = [
      ".DS_Store"
      ".vscode"
    ];

    lfs.enable = true;

    extraConfig = {
      core = {
        pager = "less -+F";
      };

      push = {
        default = "current";
      };
    };
  };
}
