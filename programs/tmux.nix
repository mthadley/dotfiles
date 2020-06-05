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
    secureSocket = !pkgs.stdenv.isDarwin;

    extraConfig = ''
      set -g status-right ""
      set -g status-justify centre

      # Fixes colors in vim
      set-option -sa terminal-overrides ',xterm-256color:RGB'

      set -g mouse on

      set -g status-fg "colour7"
      set -g status-bg "colour8"

      bind-key v split-window -h
      bind-key s split-window -v
      bind-key a last-window
    '';
  };
}
