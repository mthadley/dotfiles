{ pkgs, ... }:

let
  similar-sort = pkgs.callPackage ../../pkgs/similar-sort {};

  vim-mix-format = pkgs.vimUtils.buildVimPlugin {
    name = "mix-format";
    src = pkgs.fetchFromGitHub {
      owner = "mhinz";
      repo = "vim-mix-format";
      rev = "cbb63e65a423ea63444a5d1b41e51d1fcec5f962";
      sha256 = "037fbmcj9dfj89jd2xa1xv55baqvws85xpjmypgr3kx7y183l0b7";
    };
  };

  vim-ormolu = pkgs.vimUtils.buildVimPlugin {
    name = "vim-ormolu";
    src = pkgs.fetchFromGitHub {
      owner = "sdiehl";
      repo = "vim-ormolu";
      rev = "4ae4fe11c558af33030abdeda6f2ee1f5b54da55";
      sha256 = "13yn0arxcn8ngc91lvhcqs3nl17zcdmgsw522qvqgn732cpf0ddy";
    };
  };

  vim-prettier = pkgs.vimUtils.buildVimPlugin {
    # The source contains a Makefile in the root which is only used for tests, so
    # this stops nix from trying to run it.
    dontBuild = true;

    name = "vim-prettier";
    src = pkgs.fetchFromGitHub {
      owner = "prettier";
      repo = "vim-prettier";
      rev = "de4c4fc5d879c8d82668e47384f80ff45c1bfb42";
      sha256 = "170xi335b83rqcwq0dgdk8m13lic8lbn8vi2p7qp4yhwvqqv59q2";
    };
  };

  vim-rails = pkgs.vimUtils.buildVimPlugin {
    name = "vim-rails";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-rails";
      rev = "184d12e85a17c85c548aeecc5b5c8c3182bd22e9";
      sha256 = "01z88hrqcqqp2cd5dwffiijhzfp0pr32dvmb5ai62y8zhfyn57m9";
    };
  };

  vim-fzf-builtin = pkgs.vimUtils.buildVimPlugin {
    name = "vim-fzf-builtin";
    src = "${pkgs.fzf}/share/vim-plugins/fzf";
  };

  fzfVimPreview = "${pkgs.vimPlugins.fzf-vim}/share/vim-plugins/fzf-vim/bin/preview.sh";
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      ale
      auto-pairs
      base16-vim
      emmet-vim
      vim-abolish
      vim-commentary
      vim-fugitive
      vim-fzf-builtin
      vim-gitgutter
      vim-indent-object
      vim-indexed-search
      vim-mix-format
      vim-ormolu
      vim-polyglot
      vim-prettier
      vim-rails
      vim-repeat
      vim-sensible
      vim-sleuth
      vim-sort-motion
      vim-surround
      vim-unimpaired
      vim-vinegar
    ];

    extraConfig = ''
      set clipboard=unnamed
      set cursorline
      set expandtab
      set ignorecase
      set mouse=a
      set nobackup
      set nowritebackup
      set number
      set relativenumber
      set scrolloff=10
      set shiftround
      set shiftwidth=2
      set splitbelow
      set splitright
      set undofile

      "" Use rg as grepprg
      set grepprg=${pkgs.ripgrep}/bin/rg\ --vimgrep

      " Plugin Settings

      "" 'w0rp/ale'
      let g:ale_lint_delay = 1000
      let g:ale_lint_on_enter = 0
      let g:ale_elm_ls_elm_analyse_trigger = 'never'
      let g:ale_elm_ls_executable = '${pkgs.elmPackages.elm-language-server}/bin/elm-language-server'
      let g:ale_linters = {'haskell': ['hlint', 'hdevtools', 'hfmt']}
      let g:ale_linters_ignore = {'ruby': ['brakeman']}
      hi ALEError cterm=underline

      "" chriskempson/base16-vim
      let g:base16colorspace=256

      "" ElmCast/elm-vim
      let g:elm_setup_keybindings = 0
      let g:elm_format_autosave = 1
      let g:elm_detailed_complete = 1

      "" mhinz/vim-mix-format
      let g:mix_format_on_save = 1

      "" christoomey/vim-sort-motion
      let g:sort_motion_flags = 'i'

      "" pangloss/vim-javascript
      let g:jsx_ext_required = 0
      let g:javascript_plugin_jsdoc = 1

      "" plasticboy/vim-markdown
      let g:vim_markdown_folding_disabled = 1
      let g:vim_markdown_fenced_languages = ['js=javascript', 'ini=dosini']

      " au commands

      "" Autoreload file on change
      set autoread
      au CursorHold * checktime

      "" Remove trailing whitespace
      au BufWritePre * :%s/\s\+$//e

      "" Wrap Lines when writing Markdown
      au BufRead,BufNewFile *.md setlocal textwidth=80

      "" Formatting js
      au FileType javascript setlocal formatprg=prettier

      "" Typescript hints
      au FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

      "" Fix netrw mm and mc commands by updating lcd as you navigate
      "" Keep everything else working by updating lcd back to the global
      let g:netrw_keepdir = 0
      au BufLeave * exe "lcd" getcwd(-1)

      "" Turn on spell check for certain filetypes
      au FileType gitcommit setl spell

      " Keybinds

      let g:user_emmet_leader_key = '<C-E>'
      let mapleader = ","

      inoremap jk <ESC>

      "" fzf
      noremap <silent> <C-P> :call fzf#run(fzf#wrap({
      \ "source": "${pkgs.ripgrep}/bin/rg --files \| ${similar-sort}/bin/similar-sort \"" . @% . "\"",
      \ "sink": 'edit',
      \ "options": ['--tiebreak', 'index', '--preview', '${fzfVimPreview} {}'],
      \ "window": {'width': 1, 'height': 0.5, 'yoffset': 1},
      \ }))<CR>

      "" Open file explorer
      noremap <C-E>e :Explore<CR>
      noremap <C-E>s :Hexplore<CR>
      noremap <C-E>v :Vexplore<CR>

      "" Ale
      nnoremap <leader>e] :ALENextWrap<CR>
      nnoremap <leader>e[ :ALEPreviousWrap<CR>
      nnoremap <leader>ed :ALEDetail<CR>
      nnoremap <leader>h :ALEHover<CR>
      nnoremap <C-]> :call GoTo()<CR>

      """ Keep default behavior when browsing help files
      function! GoTo()
        if &ft == 'help'
          execute "tag " . expand("<cword>")
        else
          execute "ALEGoToDefinition"
        endif
      endfunction

      "" Session management
      noremap <leader>ss :mks! ~/.vimsession<CR>
      noremap <leader>os :so ~/.vimsession<CR>

      "" Git
      noremap <C-G>s :Gstatus<CR>
      noremap <C-G>l :Glog<CR>
      noremap <C-G>b :Gblame<CR>
      noremap <C-G>h :Gbrowse<CR>
      noremap <C-G>e :Gedit<CR>

      "" Rails
      noremap <leader>ra :A<CR>
      noremap <leader>re :R<CR>

      "" Misc

      noremap <leader>ct :!column -t<CR>
      noremap <silent> <leader>cw :call ToggleCW()<CR>
      noremap <leader>n :noh<CR>
      noremap <leader>q :q<CR>
      noremap <leader>rs :syntax sync fromstart<CR>
      noremap <leader>w :w<CR>

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
    '';
  };
}
