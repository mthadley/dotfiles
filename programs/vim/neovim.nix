{ pkgs, ... }:

let
  vim-mix-format = pkgs.vimUtils.buildVimPlugin {
    name = "mix-format";
    src = pkgs.fetchFromGitHub {
      owner = "mhinz";
      repo = "vim-mix-format";
      rev = "cbb63e65a423ea63444a5d1b41e51d1fcec5f962";
      sha256 = "037fbmcj9dfj89jd2xa1xv55baqvws85xpjmypgr3kx7y183l0b7";
    };
  };
in
{
  programs.neovim = {
    enable = true;

    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      ale
      vim-sort-motion
      base16-vim
      vim-hindent
      vim-gitgutter
      vim-indexed-search
      auto-pairs
      fzf-vim
      emmet-vim
      vim-polyglot
      vim-abolish
      vim-commentary
      vim-fugitive
      vim-repeat
      vim-sensible
      vim-sleuth
      vim-surround
      vim-unimpaired
      vim-vinegar
      vim-mix-format
    ];

    extraConfig = ''
      set clipboard=unnamed
      set cursorline
      set dir=/tmp
      set expandtab
      set formatoptions+=j
      set hlsearch
      set ignorecase
      set mouse=a
      set nobackup
      set number
      set relativenumber
      set scrolloff=10
      set shiftwidth=2
      set splitbelow
      set splitright
      set sts=2
      set tabstop=2

      "" Use rg as grepprg
      if executable('rg')
        set grepprg=rg\ --vimgrep
      endif

      " Plugin Settings

      "" 'w0rp/ale'
      let g:ale_lint_delay = 1000
      let g:ale_lint_on_enter = 0
      let g:ale_elm_ls_elm_analyse_trigger = 'never'
      let g:ale_elm_ls_executable = '${pkgs.elmPackages.elm-language-server}/bin/elm-language-server'
      let g:ale_linters = {
      \   'javascript': ['eslint', 'flow', 'flow-language-server', 'standard', 'xo'],
      \}
      hi ALEError cterm=underline

      "" chriskempson/base16-vim
      let g:base16colorspace=256

      "" junegunn/fzf.vim
      let g:fzf_action = {
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit' }

      """ Hide bar while fzf is open
      """ Taken from https://github.com/junegunn/fzf.vim#hide-statusline
      if has('nvim') || has('gui_running')
        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler norelativenumber
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler relativenumber
      endif

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

      au BufRead,BufNewFile *.css set filetype=scss

      "" Wrap Lines when writing Markdown
      au BufRead,BufNewFile *.md setlocal textwidth=80

      "" Formatting js
      au FileType javascript setlocal formatprg=prettier

      "" Typescript hints
      au FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

      " Keybinds

      let g:user_emmet_leader_key = '<C-E>'
      let mapleader = ","

      inoremap jk <ESC>

      "" fzf
      noremap <C-P> :Files<CR>

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
      noremap <leader>cw :call ToggleCW()<CR>
      noremap <leader>ev :e $MYVIMRC<CR>
      noremap <leader>n :noh<CR>
      noremap <leader>q :q<CR>
      noremap <leader>rs :syntax sync fromstart<CR>
      noremap <leader>w :w<CR>

      " Colors

      colorscheme base16-ocean
      set background=dark
      set termguicolors

      hi CursorLineNr cterm=bold

      " Setup persistent undo

      if has('persistent_undo')
        let undo_dir = expand('$HOME/.vim/undo_dir')
        if !isdirectory(undo_dir)
          call mkdir(undo_dir, "p", 0700)
        endif
        set undodir=$HOME/.vim/undo_dir
        set undofile
      endif

      " Functions

      function! ToggleCW()
        for i in range(1, winnr('$'))
          let bnum = winbufnr(i)
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
