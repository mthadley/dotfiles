{ pkgs, ... }:

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

    delta = {
      enable = true;

      options = [
        "--paging always"
        "--file-style plain"
        "--hunk-style plain"
      ];
    };

    extraConfig = {
      pull = {
        ff = "only";
      };

      push = {
        default = "current";
      };
    };
  };
}
