{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      pain-control
      yank
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
      # general options
      set -g mouse on
      set -g renumber-windows on

      # status line
      set -g status-right ""
      set -g status-justify centre

      # colors
      set -g status-style fg="#7f8894",bg="#343d46"
      set -g pane-border-style fg="#343d46"
      set -g window-status-current-style fg=green

      # Fixes colors in vim
      set -sa terminal-overrides ',xterm-256color:RGB'

      bind-key v split-window -h
      bind-key s split-window -v
      bind-key a last-window
    '';
  };
}
