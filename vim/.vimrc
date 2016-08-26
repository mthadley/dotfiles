" Vundle Stuff
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'christoomey/vim-sort-motion'
Plugin 'ElmCast/elm-vim'
Plugin 'henrik/vim-indexed-search'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'lepture/vim-velocity'
Plugin 'mattn/emmet-vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mthadley/syntastic-csf'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'rking/ag.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'travitch/hasksyn'

" vim-jsx requires vim-javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

call vundle#end()
filetype plugin indent on

" Mike's stuff
set cursorline
set dir=/tmp
set expandtab
set fileformats+=dos
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

let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 1

let g:sort_motion_flags = 'i'

let g:jsx_ext_required = 0

let g:syntastic_css_checkers = ['csf']
let g:syntastic_javascript_checkers = ['csf']
let g:syntastic_scss_checkers = ['csf']

let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.?(git|hg|svn|node_modules)$',
	\ }

" Use system clipboard as default
set clipboard+=unnamed

" Autoreload file on change
set autoread
au CursorHold * checktime

" Remove trailing whitespace
au BufWritePre * :%s/\s\+$//e

" Force syntax highlighting for certain file extensions
au BufRead,BufNewFile *.css set filetype=scss
au BufRead,BufNewFile *.jspf,*.tag set filetype=jsp

" Liferay doesn't like trailing newlines...
au BufRead,BufNewFile */Liferay/* setlocal noeol binary sw=4 sts=4 ts=4 noet

" Ignore HTML files
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Keybinds
let g:user_emmet_leader_key = '<C-E>'
let mapleader = ","

inoremap jk <ESC>

" Open file epxloer
noremap <C-E>e :Explore<CR>
noremap <C-E>s :Hexplore<CR>
noremap <C-E>v :Vexplore<CR>

" Add trailing semicolon
noremap <leader>; m'A;<ESC>g`'

" Join collection of items to a single line
noremap <leader>ja ?[\\|{\\|(<CR>v%Jx%lx:noh<CR>

" Split collection of items to multiple lines
noremap <leader>sa ?[\\|{\\|(<CR>v%:s/,/\0\r/g<CR>wi<CR><ESC>%li<CR><ESC>?[\\|{\\|(<CR>v%=:noh<CR>

" Session management
noremap <leader>ss :mks! ~/.vimsession<CR>
noremap <leader>os :so ~/.vimsession<CR>

" Projections
noremap <leader>a :A<CR>
noremap <leader>as :AS<CR>
noremap <leader>av :AV<CR>

" Misc
noremap <leader>bw :set binary<CR>:w<CR>:set nobinary<CR>:ec "File Written(b)..."<CR>
noremap <leader>c :SyntasticToggleMode<CR>
noremap <leader>ccp :CtrlPClearAllCaches<CR>
noremap <leader>ct :!column -t<CR>
noremap <leader>ev :vsplit $MYVIMRC<CR>
noremap <leader>f :CtrlPFunky<CR>
noremap <leader>n :noh<CR>
noremap <leader>q :q<CR>
noremap <leader>rs :syntax sync fromstart<CR>
noremap <leader>w :w<CR>

" Colors
set background=dark
colorscheme solarized
