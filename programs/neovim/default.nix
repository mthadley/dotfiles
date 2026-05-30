{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode-langservers-extracted
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    # Apparently needed to compile some Treesitter grammars (like Markdown)
    # and no GCC was being found on MacOS.
    gcc
  ];

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      base16-nvim
      conform-nvim
      fzf-lua
      gitsigns-nvim
      nvim-autopairs
      nvim-lspconfig
      nvim-surround
      nvim-treesitter
      tslime-vim
      vim-indent-object
      vim-sleuth
      vim-sort-motion
      vim-test
      vim-unimpaired
      vim-vinegar

      # Fugitive + related plugins
      vim-fugitive
      vim-rhubarb
    ];

    initLua = ''
      FD_PATH = "${pkgs.fd}/bin/fd"
      RIPGREP_PATH = "${pkgs.ripgrep}/bin/rg"
      ZIMILAR_ZORT_PATH = "${pkgs.zimilar-zort}/bin/zimilar-zort"

      require "mthadley"
    '';

    # In `home.stateVersion` < 26.05 (at time of writing I still have
    # 23.11), these defaulted to `true`. In order to silence a home-manager
    # warning I need to explicitly set this, and seems fine to use the
    # new default of `false`.
    #
    # Remove if I ever update that `stateVersion`.
    withPython3 = false;
    withRuby = false;
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config;
  };
}
