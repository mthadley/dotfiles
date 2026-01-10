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

    includes = [
      {
        condition = "gitdir:~/projects/workos/**";
        path = "~/projects/workos/.gitconfig";
      }
    ];
  };

  programs.delta = {
    enable = true;

    options = {
      line-numbers = true;
      paging = "always";
    };
  };
}
