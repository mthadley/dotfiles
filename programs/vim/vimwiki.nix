{ pkgs, ... }:

let
  git = "${pkgs.git}/bin/git";

  autosave-script = pkgs.writeScript "mike-wiki-autosave" ''
    #!${pkgs.stdenv.shell}
    set -eou pipefail

    WIKI_DIR="$HOME/mike-wiki"

    if [[ ! -e $WIKI_DIR ]]; then
      echo "No wiki directory. Exiting."
      exit 0
    fi

    cd "$WIKI_DIR"

    if [[ ! $(${git} status --porcelain) ]]; then
      echo "No files to commit. Exiting."
      exit 0
    fi

    ${git} commit -a -m "Autosave" -m "Autosaving changes from $(hostname)"
    ${git} push origin
  '';
in
{
  systemd.user = {
    timers.mike-wiki = {
      Unit.Description = "Trigger automatic saving of mike-wiki";

      Timer = {
        OnBootSec = "15min";
        OnCalendar = "17:30";
        Persistent = true;
      };

      Install.WantedBy = ["timers.target"];
    };

    services.mike-wiki = {
      Unit.Description = "Autosave changes to mike-wiki";

      Service = {
        Type = "oneshot";
        ExecStart = "${autosave-script}";
      };
    };
  };
}
