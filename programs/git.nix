{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userEmail = "mikethadley@gmail.com";
    userName = "Michael Hadley";

    ignores = [
      ".DS_Store"
      ".vscode"
      ".direnv"
    ];

    lfs.enable = true;

    delta = {
      enable = true;

      options = {
        line-numbers = true;
        paging = "always";
      };
    };

    extraConfig = {
      pull.ff = "only";
      push.default = "current";
      init.defaultBranch = "main";
    };
  };
}
