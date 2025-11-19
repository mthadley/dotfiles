{ pkgs, ... }:

{
  home.packages = with pkgs; lib.optionals pkgs.hostPlatform.isDarwin [
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
      registers-nvim
      tslime
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

    extraLuaConfig = ''
      FD_PATH = "${pkgs.fd}/bin/fd"
      RIPGREP_PATH = "${pkgs.ripgrep}/bin/rg"
      ZIMILAR_ZORT_PATH = "${pkgs.zimilar-zort}/bin/zimilar-zort"

      require "mthadley"
    '';
  };

  home.file.".config/nvim" = {
    recursive = true;
    source = ./config;
  };
}
