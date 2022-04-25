{ pkgs, ... }:

let
  vim-fzf-builtin = pkgs.vimUtils.buildVimPlugin {
    name = "vim-fzf-builtin";
    src = "${pkgs.fzf}/share/vim-plugins/fzf";
  };

  fzfVimPreview = "${pkgs.vimPlugins.fzf-vim}/bin/preview.sh";
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      auto-pairs
      base16-vim
      gitsigns-nvim
      neoformat
      nvim-lspconfig
      tslime
      vim-abolish
      vim-commentary
      vim-fugitive
      vim-fzf-builtin
      vim-indent-object
      vim-polyglot
      vim-rails
      vim-repeat
      vim-sort-motion
      vim-surround
      vim-test
      vim-unimpaired
      vim-vinegar
    ];

    extraConfig = ''
      "" Use rg as grepprg
      set grepprg=${pkgs.ripgrep}/bin/rg\ --vimgrep

      " Plugin Settings

      "" chriskempson/base16-vim
      let g:base16colorspace=256

      "" fzf
      let g:fzf_colors = { 'border': ['fg', 'Comment'] }
      let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit' }

      "" christoomey/vim-sort-motion
      let g:sort_motion_flags = 'i'

      "" pangloss/vim-javascript
      let g:jsx_ext_required = 0
      let g:javascript_plugin_jsdoc = 1

      "" plasticboy/vim-markdown
      let g:vim_markdown_folding_disabled = 1
      let g:vim_markdown_fenced_languages = ['js=javascript', 'ini=dosini']

      "" vim-test
      let g:test#strategy = 'tslime'

      "" tslime
      let g:tslime_always_current_session = 1
      let g:tslime_always_current_window = 1

      " au commands

      "" Only show cursorline in active window
      au WinLeave * setl nocursorline
      au WinEnter * setl cursorline

      "" Autoreload file on change
      set autoread
      au CursorHold * checktime

      "" Remove trailing whitespace
      au BufWritePre * :%s/\s\+$//e

      "" Wrap Lines when writing Markdown
      au BufRead,BufNewFile *.md setlocal textwidth=80

      "" Fix netrw mm and mc commands by updating lcd as you navigate
      "" Keep everything else working by updating lcd back to the global
      let g:netrw_keepdir = 0
      au BufLeave * exe "lcd" getcwd(-1)

      "" Recognize go templates
      au BufReadPost *.go.tmpl set ft=gohtmltmpl

      " Keybinds

      let mapleader = ","

      inoremap jk <ESC>

      "" fzf
      noremap <silent> <C-P> :call fzf#run(fzf#wrap({
      \ "source": "${pkgs.ripgrep}/bin/rg --files \| ${pkgs.similar-sort}/bin/similar-sort \"" . @% . "\"",
      \ "options": ['--tiebreak', 'index', '--preview', '${fzfVimPreview} {}'],
      \ "window": {'width': 1, 'height': 0.5, 'yoffset': 1},
      \ }))<CR>

      "" Open file explorer
      noremap <C-E>e :Explore<CR>
      noremap <C-E>s :Hexplore<CR>
      noremap <C-E>v :Vexplore<CR>

      "" Session management
      noremap <leader>ss :mks! ~/.vimsession<CR>
      noremap <leader>os :so ~/.vimsession<CR>

      "" Rails
      noremap <leader>ra :A<CR>
      noremap <leader>re :R<CR>

      "" vim-test
      noremap tt :TestFile<CR>
      noremap tn :TestNearest<CR>
      noremap ta :TestSuite<CR>
      noremap tl :execute "Tmux bundle exec rubocop " . expand("%:p")<CR>

      "" Saving
      noremap <leader>w :w<CR>
      noremap <C-S> :w<CR>
      inoremap <C-S> :w<CR>

      "" Misc

      noremap <leader>ct :!column -t<CR>
      noremap <silent> <leader>cw :call ToggleCW()<CR>
      noremap <leader>n :noh<CR>
      noremap <leader>q :q<CR>
      noremap <leader>rs :syntax sync fromstart<CR>

      " Colors

      set termguicolors
      colorscheme base16-ocean

      hi CursorLineNr cterm=bold

      " Functions

      function! ToggleCW()
        for i in range(1, winnr('$'))
          let l:bnum = winbufnr(i)
          if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
          endif
        endfor
        copen
      endfunction

      lua require 'mthadley.init'
    '';
  };

  home.file.".config/nvim/lua" = {
    recursive = true;
    source = ./lua;
  };

  home.file.".config/nvim/autoload/neoformat/formatters/purescript.vim".text = ''
    function! neoformat#formatters#purescript#enabled() abort
        return ['purty']
    endfunction

    function! neoformat#formatters#purescript#purty() abort
        return {
            \ 'exe': 'purty',
            \ 'args': ['-'],
            \ 'stdin': 1
            \ }
    endfunction
  '';
}
