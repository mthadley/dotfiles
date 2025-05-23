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
    terminal =
      # MacOS has an outdated version of ncurses, which means it
      # doesn't recognize the `tmux-256color` terminfo. Most modern
      # versions of linux don't have this problem. Stolen from:
      # https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
      if pkgs.stdenv.isDarwin then
        "screen-256color"
      else
        "tmux-256color";
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

      bind-key v split-window -c "#{pane_current_path}" -h
      bind-key s split-window -c "#{pane_current_path}" -v
      bind-key a last-window
    '';
  };
}
