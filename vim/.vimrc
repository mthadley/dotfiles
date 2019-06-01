" Plugins
call plug#begin('~/.vim/bundle')

Plug '/usr/local/opt/fzf'
Plug 'airblade/vim-gitgutter'
Plug 'cakebaker/scss-syntax.vim'
Plug 'cespare/vim-toml'
" Switch back to 'chriskempson/base16-vim' after #197 has been fixed
Plug 'danielwe/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'dag/vim-fish'
Plug 'duganchen/vim-soy'
Plug 'edkolev/tmuxline.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'ElmCast/elm-vim'
Plug 'henrik/vim-indexed-search'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'lepture/vim-velocity'
Plug 'LnL7/vim-nix'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mustache/vim-mustache-handlebars'
Plug 'neovimhaskell/haskell-vim'
Plug 'plasticboy/vim-markdown'
Plug 'prettier/vim-prettier'
Plug 'rust-lang/rust.vim'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'

"" vim-jsx requires vim-javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()

" Settings

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

"" Fix mouse resizing when in tmux
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

"" Synax is slow in Ruby
set regexpengine=1

" Setup Find

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

command! -nargs=+ -complete=file Find execute 'silent! grep <args> | redraw! | copen'

" Plugin Settings

"" 'w0rp/ale'
let g:ale_completion_enabled = 0
let g:ale_set_highlights = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
\   'javascript': ['eslint', 'flow', 'flow-language-server', 'standard', 'xo'],
\}

"" chriskempson/base16-vim
let g:base16colorspace=256

"" edkolev/tmuxline.vim
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#(uptime | cut -d "," -f 1 | cut -d " " -f 3-)',
      \'c'    : '',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '',
      \'y'    : '#H',
      \'z'    : '#(date +"%a %b %e %R %p")'}

"" junegunn/fzf.vim
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

"" ElmCast/elm-vim
let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 1
let g:elm_detailed_complete = 1

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
au BufRead,BufNewFile *.jspf,*.tag set filetype=jsp

"" Wrap Lines when writing Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

"" Formatting js
au FileType javascript setlocal formatprg=prettier

"" Typescript hints
au FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

"" Elm
augroup filetype_elm_test
    au!
    au FileType elm highlight ALEError ctermfg=1
    au BufNewFile,BufRead ui/tests/**/*.elm
          \ let b:ale_elm_make_executable= '/Users/mthadley/projects/NoRedInk/ui/node_modules/.bin/elm-test'
          \ | let b:ale_elm_make_use_global=1
augroup END

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
nnoremap ]e :ALENextWrap<CR>
nnoremap [e :ALEPreviousWrap<CR>

"" Session management
noremap <leader>ss :mks! ~/.vimsession<CR>
noremap <leader>os :so ~/.vimsession<CR>

"" Projections
noremap <leader>to :A<CR>
noremap <leader>ts :AS<CR>
noremap <leader>tv :AV<CR>

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

noremap <leader>bw :set binary<CR>:w<CR>:set nobinary<CR>:ec "File Written(b)..."<CR>
noremap <leader>ct :!column -t<CR>
noremap <leader>cw :call ToggleCW()<CR>
noremap <leader>ev :vsplit $MYVIMRC<CR>
noremap <leader>n :noh<CR>
noremap <leader>q :q<CR>
noremap <leader>rs :syntax sync fromstart<CR>
noremap <leader>w :w<CR>

"" Fix Arrows when in tmux
noremap <Esc>[A <Up>
noremap <Esc>[B <Down>
noremap <Esc>[C <Right>
noremap <Esc>[D <Left>
cmap <Esc>[A <Up>
cmap <Esc>[B <Down>
cmap <Esc>[C <Right>
cmap <Esc>[D <Left>

" Colors

colorscheme base16-ocean
set background=dark

" Setup persistent undo

if has('persistent_undo')
  let undo_dir = expand('$HOME/.vim/undo_dir')
  if !isdirectory(undo_dir)
    call mkdir(undo_dir, "", 0700)
  endif
  set undodir=$HOME/.vim/undo_dir
  set undofile
endif

" Projections

let g:projectionist_heuristics = {
\ "package.json": {
\		"**/__tests__/*.js": {
\			"alternate": [
\				"{}.js",
\				"{dirname}/{basename|snakecase}/index.js"
\			],
\			"type": "test"
\		},
\		"*.js": {
\			"alternate": [
\				"{dirname}/__tests__/{basename}.js",
\				"{dirname}/../__tests__/{dirname|basename|camelcase|capitalize}.js",
\				"{dirname}/__tests__/{dirname|basename|camelcase|capitalize}.js"
\			],
\			"type": "source"
\		}
\}}

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
