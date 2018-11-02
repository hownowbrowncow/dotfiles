call plug#begin('~/.vim/plugged')

" Themes
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'

" Auto-completion
Plug 'valloric/youcompleteme'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'othree/javascript-libraries-syntax.vim'

" Linting/Formatting
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'

" Utility
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ap/vim-buftabline'

" TypeScript
Plug 'leafgarland/typescript-vim'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" *SS
Plug 'JulesWang/css.vim'
Plug 'groenewege/vim-less'
Plug 'cakebaker/scss-syntax.vim'

call plug#end()

filetype on
filetype indent on

syntax on
syntax enable

let mapleader=','

if has('mouse')
  set mouse=a
endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set encoding=utf-8

" Undo
set undofile
set undodir=~/.vim/undo
set undolevels=100

" History
set history=100

" Theme config
set background=dark
set t_Co=256

" Consistent timeout
set timeoutlen=200

" Better searching
set incsearch
set ignorecase
set smartcase

" Scrolling
set scrolloff=10

" Indenting
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

" Visual
set number
set visualbell
set noruler
set viminfo='20,\"50
set display+=lastline
set noshowmode
set noshowcmd
set laststatus=2

" No sawp files
set nobackup
set nowb
set noswapfile

set omnifunc=syntaxcomplete#Complete

" Number mode
nmap <leader>n :set number<CR>
nmap <leader>N :set nonumber<CR>

" Copy/Paste
nmap <leader>p :set paste<CR>
nmap <leader>P :set nopaste<CR>

" Buffers
nmap <leader>c :bdelete<CR>
nmap <C-n> :bnext<CR>
nmap <C-b> :bprevious<CR>

" NERDTree toggle
nmap <C-f> :NERDTreeToggle<CR>

let g:ctrlp_show_hidden=1

let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

let delimitMate_expand_cr=1

let g:UltiSnipsExpandTrigger="<C-j>"

let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_scss_stylelint_options = '--custom-syntax postcss-scss'
let g:ale_linters={
  \ 'typescript': ['tslint'],
  \ 'javascript': ['eslint'],
  \ 'scss': ['stylelint'],
  \ 'php': ['phpcs'],
\}

" Set filetypes for non-standard files
autocmd BufNewFile,BufRead .eslintrc,.babelrc,.stylelintrc set filetype=json
