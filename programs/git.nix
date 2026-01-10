{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Michael Hadley";
        email = "m@mthadley.com";
      };
      pull.ff = "only";
      push.default = "current";
      init.defaultBranch = "main";
    };

    ignores = [
      ".DS_Store"
      ".vscode"
      ".direnv"
    ];

    lfs.enable = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;

    options = {
      line-numbers = true;
      paging = "always";
    };
  };
}
