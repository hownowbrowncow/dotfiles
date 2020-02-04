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
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

" Utility
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ap/vim-buftabline'
Plug 'mileszs/ack.vim'
Plug 'romainl/vim-qf'

" TypeScript
Plug 'leafgarland/typescript-vim'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'storyn26383/vim-vue'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" PHP
Plug 'nelsyeung/twig.vim'
Plug 'jwalton512/vim-blade'

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
set backspace=indent,eol,start

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
set tabstop=2
set shiftwidth=2
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
set completeopt-=preview

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

let g:PHP_vintage_case_default_indent=0

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:ctrlp_show_hidden=1

let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

let delimitMate_expand_cr=1

let g:UltiSnipsExpandTrigger="<C-j>"

let g:qf_auto_quit = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_scss_stylelint_options = '--custom-syntax postcss-scss'
let g:ale_linters={
  \ 'typescript': ['eslint'],
  \ 'javascript': ['eslint'],
  \ 'scss': ['stylelint'],
  \ 'php': ['phpcs'],
\}

let g:ctrlp_max_files=20000
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules\|vendor\|git'

hi Error term=standout ctermfg=3 ctermbg=18 guifg=#f4bf75 guibg=#383830
hi SpellBad term=standout ctermfg=3 ctermbg=18 guifg=#f4bf75 guibg=#383830

" Set filetypes for non-standard files
autocmd BufNewFile,BufRead .eslintrc,.babelrc,.stylelintrc set filetype=json
" Wrap long errors in qf (lint) window
autocmd FileType qf setlocal wrap
