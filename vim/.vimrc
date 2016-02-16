" Vundle Stuff
set nocompatible
filetype off

let g:syntastic_javascript_checkers = ['csf']

set rtp+=~/.vim/Bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-sort-motion'
Plugin 'henrik/vim-indexed-search'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'lambdatoast/elm.vim'
Plugin 'lepture/vim-velocity'
Plugin 'mattn/emmet-vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mthadley/syntastic-csf'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'travitch/hasksyn'
Plugin 'Valloric/YouCompleteMe'

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
set tabstop=2
set sts=2

let g:bufferline_echo = 0
let g:gitgutter_sign_removed = '-'
let g:sort_motion_flags = 'i'
let g:jsx_ext_required = 0

let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.?(git|hg|svn|node_modules)$',
	\ }

" Use system clipboard as default
set clipboard+=unnamedplus

" Autoreload file on change
set autoread
au CursorHold * checktime

" Force syntax highlighting for certain file extensions
au BufRead,BufNewFile *.css set filetype=scss
au BufRead,BufNewFile *.jspf,*.tag set filetype=jsp

" Liferay doesn't like trailing newlines...
au BufRead,BufNewFile */Liferay/* setlocal noeol binary sw=4 sts=4 ts=4 noet

" Ignore HTML files
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Keybinds
inoremap jk <ESC>

let mapleader = ","
noremap <leader>bw :set binary<CR>:w<CR>:set nobinary<CR>:ec "File Written(b)..."<CR>
noremap <leader>c :SyntasticToggleMode<CR>
noremap <leader>ct :!column -t<CR>
noremap <leader>ccp :CtrlPClearAllCaches<CR>
noremap <leader>ev :vsplit $MYVIMRC<CR>
noremap <leader>n :noh<CR>
noremap <leader>f :CtrlPFunky<CR>
noremap <leader>r :NERDTreeFind<CR>
noremap <leader>rs :syntax sync fromstart<CR>
noremap <leader>t :NERDTreeToggle<CR>
noremap <leader>w :w<CR>

let g:user_emmet_leader_key = '<C-E>'

" Colors
let g:base16colorspace=256
colorscheme base16-eighties
set background=dark
hi TabLineFill ctermfg=Black ctermbg=Black
hi TabLine ctermfg=Black ctermbg=Grey
hi TabLineSel ctermfg=Green ctermbg=Black
hi Search ctermbg=gray

highlight clear SignColumn
highlight GitGutterAddLine ctermbg=Black
highlight GitGutterChangeLine ctermbg=Black
highlight GitGutterDeleteLine ctermbg=Black
highlight GitGutterChangeDeleteLine ctermbg=Black
