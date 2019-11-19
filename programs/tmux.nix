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
    escapeTime = 10;

    # This tries to set $TMUX_TMPDIR to /run/... which doesn't
    # seem to work on MacOS.
    secureSocket = false;

    extraConfig = ''
      set -g status-right ""
      set -g status-justify centre

      set -g mouse on

      set -g status-fg "colour20"
      set -g status-bg "colour18"

      set-option -sa terminal-overrides ',xterm-256color:RGB'

      bind-key v split-window -h
      bind-key s split-window -v
      bind-key a last-window
    '';
  };
}
