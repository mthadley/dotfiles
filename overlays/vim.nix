self: super:

{
  vim_configurable = super.vim_configurable.override {
    # For some reason this `vim_configurable` coming from nixpkgs
    # has `darwinSupport` set to false by default, breaking my clipboard
    # among other things.
    #
    # This can be checked by running `:version` in vim. The "bad" version
    # from nixpkgs has "w/o darwin" and a bunch of gui/X11 features enabled.
    # Compare that to the homebrew version of vim, which doesn't have any of
    # the gui features, and is compiled with darwin support.
    #
    # Also need to set `guiSupport`/`--enable-gui="noj"` with darwin enabled,
    # as otherwise the compilation fails.
    darwinSupport = self.stdenv.isDarwin;
    guiSupport = "no";
  };
}
