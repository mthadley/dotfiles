{
  # `dircolors` makes the colored output from `fd` not look
  # terrible and match my terminal theme. Apparently because
  # this module sets an `LS_COLORS` environment variable.
  #
  # Otherwise, I'm not sure there would be a need for it.
  programs.dircolors = {
    enable = true;
  };
}
