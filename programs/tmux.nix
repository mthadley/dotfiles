{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      pain-control
    ];

    historyLimit = 10000;
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen-256color";

    # This tries to set $TMUX_TMPDIR to /run/... which doesn't
    # seem to work on MacOS.
    secureSocket = false;

    extraConfig = ''
      set -g status-right ""
      set -g status-justify centre

      set -g status-fg "colour20"
      set -g status-bg "colour18"

      bind-key v split-window -h
      bind-key s split-window -v
      bind-key a last-window
    '';
  };
}
