" Vundle Stuff
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/Bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
"  " required!
Plugin 'gmarik/vundle.vim'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'ervandew/supertab'
Plugin 'henrik/vim-indexed-search'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'lepture/vim-velocity'
Plugin 'mattn/emmet-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on     " required!

" Vim Airline stuff
set encoding=UTF-8
set t_Co=256
set laststatus=2
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" Mike's stuff
set cursorline
set fileformats+=dos
set ignorecase
set mouse=a
set nobackup
set number
set relativenumber
set shiftwidth=4
set tabstop=4
set hlsearch
let g:bufferline_echo = 0
inoremap jk <ESC>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
let g:ctrlp_cmd = 'CtrlPCurWD'

" Autoreload file on change
set autoread
au CursorHold * checktime

let g:gitgutter_sign_removed = '-'

au BufRead,BufNewFile *.css set filetype=scss.css

let g:tmuxline_preset = 'full'
let g:tmuxline_powerline_separators = 0

let mapleader = ","
map <leader>t :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>
map <leader>gh :Gbrowse<CR>
map <leader>s :buffer
map <leader>c :SyntasticToggleMode<CR>
map <leader>w :set binary<CR>:w<CR>:set nobinary<CR>:ec "File Written(b)..."<CR>

let g:user_emmet_leader_key = '<C-E>'

" Colors
let g:base16colorspace=256
colorscheme Tomorrow-Night-Eighties
hi TabLineFill ctermfg=Black ctermbg=Black
hi TabLine ctermfg=Black ctermbg=Grey
hi TabLineSel ctermfg=Green ctermbg=Black

hi Search ctermbg=gray

highlight clear SignColumn
highlight GitGutterAddLine ctermbg=Black
highlight GitGutterChangeLine ctermbg=Black
highlight GitGutterDeleteLine ctermbg=Black
highlight GitGutterChangeDeleteLine ctermbg=Black
