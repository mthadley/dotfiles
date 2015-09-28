" Vundle Stuff
set nocompatible
filetype off

set rtp+=~/.vim/Bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
"  " required!
Plugin 'gmarik/vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'henrik/vim-indexed-search'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'lepture/vim-velocity'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mattn/emmet-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on     " required!

" Vim Airline stuff
set encoding=UTF-8
set t_Co=256
set laststatus=2
let g:airline_theme='base16'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" Mike's stuff
set cursorline
set fileformats+=dos
set hlsearch
set ignorecase
set mouse=a
set nobackup
set number
set relativenumber
set scrolloff=10
set shiftwidth=4
set tabstop=4
let g:bufferline_echo = 0
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:gitgutter_sign_removed = '-'

" Use system clipboard as default
set clipboard+=unnamedplus

" Autoreload file on change
set autoread
au CursorHold * checktime

" Force syntax highlighting for certain file extensions
au BufRead,BufNewFile *.css set filetype=scss.css
au BufRead,BufNewFile *.jspf,*.tag set filetype=jsp

" Ignore HTML files
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Tmux integration
let g:tmuxline_preset = 'full'
let g:tmuxline_powerline_separators = 0

" Keybinds
inoremap jk <ESC>
nnoremap ; :CtrlPBuffer<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

let mapleader = ","
map <leader>c :SyntasticToggleMode<CR>
map <leader>f :CtrlPFunky<CR>
map <leader>gh :Gbrowse<CR>
map <leader>r :NERDTreeFind<CR>
map <leader>s :buffer
map <leader>t :NERDTreeToggle<CR>
map <leader>w :set binary<CR>:w<CR>:set nobinary<CR>:ec "File Written(b)..."<CR>

let g:user_emmet_leader_key = '<C-E>'

" Colors
let base16colorspace=256
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
