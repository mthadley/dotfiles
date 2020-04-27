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

    extraConfig = {
      core = {
        pager = ''
          BAT_PAGER='less -c -+F' \
          ${pkgs.gitAndTools.delta}/bin/delta \
          --paging always \
          --file-style plain \
          --hunk-style plain
        '';
      };

      push = {
        default = "current";
      };
    };
  };
}
