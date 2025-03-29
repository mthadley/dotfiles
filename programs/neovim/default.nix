{ pkgs, ... }:

{
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

      # Local stuff
      copilot-lua
    ];

    extraLuaConfig = ''
      RIPGREP_PATH = "${pkgs.ripgrep}/bin/rg"
      ZIMILAR_ZORT_PATH = "${pkgs.zimilar-zort}/bin/zimilar-zort"
      NODE_PATH = "${pkgs.nodejs_22}/bin/node"

      require "mthadley"
    '';
  };

  home.file.".config/nvim" = {
    recursive = true;
    source = ./config;
  };
}
