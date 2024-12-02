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
      # versions of linuxn don't have this problem. Stolen from:
      # https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
      if pkgs.stdenv.isDarwin then
        "screen-256color"
      else
        "tmux-256color";
    escapeTime = 10;

    # This tries to set $TMUX_TMPDIR to /run/... which doesn't
    # seem to work on MacOS.
    secureSocket = !pkgs.stdenv.isDarwin;

    # This is the new default, at least as of this commit:
    #
    #   https://github.com/gen740/home-manager/commit/210b05db9779798d7ec3e5cf6a4eebc7de22dfea
    #
    # And I care because without this, tmux will default to using `sh` as the
    # shell. This can potentially be removed on later releases of `home-manager`.
    sensibleOnTop = false;

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
