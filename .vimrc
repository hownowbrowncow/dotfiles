" use vim mode instead of vi
set nocompatible

try
    colorscheme desert
catch
end
execute pathogen#infect()

filetype on
filetype plugin on
filetype indent on
let mapleader = ','

:nmap <c-s> :w<CR>

" This is so we don't get a delay between ESC and O
set timeoutlen=200
" turn mouse mode on if there is one
if has('mouse')
    set mouse=a
endif
" Disable backups
set nobackup
set nowb
set noswapfile

syntax on                                                                                                                                                            
syntax enable

" incremental search
set incsearch
" ignore case while search
set ignorecase
" case sensitive when capital letter used in search
set smartcase
" lines +/- of cursor
set scrolloff=10
" # of allowed undos
set undolevels=100
" enables auto indenting
set autoindent
" detects correct indenting based on file type
set smartindent
" tab spaces and backspaces
set smarttab
" 4 spaces tabs
set tabstop=4
set shiftwidth=4
set expandtab
" make backspace work like most other apps
set backspace=2

" turn on line numbers
set number
" DING
set visualbell
" display cursor position stats in bottom right
set ruler
" dipslay vim info to 50%
set viminfo='20,\"50
" command history
set history=100
" tab completion
set wildmenu
set display+=lastline

nmap <leader>m :set mouse=a<CR>
nmap <leader>M :set mouse=<CR>
nmap <leader>n :set number<CR>
nmap <leader>N :set nonumber<CR>
nmap <leader>p :set paste<CR>
nmap <leader>P :set nopaste<CR>
nmap <leader>h :set filetype=html<CR>
nmap <leader>H :set filetype=php<CR>
nmap <leader>t :tabnew

" Run current file with phpunit
nmap <leader>tc :!clear && phpunit -v -c /var/www/restaurant/phpunit.xml %<cr>
" Run all tests from current directory
nmap <leader>ta :!clear && phpunit -v -c $(pwd)/phpunit.xml<cr>

" PSR2 for PHP
let g:phpqa_codesniffer_args="--standard=PSR2"
" PHP Code Sniffer binary (default = "phpcs")
let g:phpqa_codesniffer_cmd='~/.composer/vendor/bin/phpcs'
" Don't run messdetector on save (default = 1)
let g:phpqa_messdetector_autorun = 0
" Don't run codesniffer on save (default = 1)
let g:phpqa_codesniffer_autorun = 1
" Show code coverage on load (default = 0)
let g:phpqa_codecoverage_autorun = 0

" lint after read
let jshint2_read = 1
" lint after save
let jshint2_save = 1
" skip confirm for non js files
let jshint2_confirm = 0
