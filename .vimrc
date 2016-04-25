" use vim mode instead of vi
set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'pangloss/vim-javascript'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'JulesWang/css.vim'
Plugin 'groenewege/vim-less'
Plugin 'cakebaker/scss-syntax.vim'

call vundle#end()

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

" Disable backups because git and they are annoying
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
" display word wrap better
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

autocmd BufNewFile,BufRead *.json set filetype=json

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" enable to show debug output
"let g:syntastic_debug = 3
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['phpcs']
let g:syntastic_php_phpcs_args = '--standard=PSR2'
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_include_dirs = ['/usr/local/apr/include/apr-1']
let g:syntastic_c_cflags = '-std=c99 -Wall -pedantic'
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [],'passive_filetypes': ['json'] }
nnoremap <leader>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0

" use tab/s-tab to move up and down and enter to select snippet
" makes YouCompleteMe and UltiSnips work together better
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction

inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

" Run PHPUnit tests
function! RunPHPUnitTest()
    cd %:p:h
    let result = system("phpunit -c " . $PHPUNIT_CONFIG . " " . bufname("%"))
    split __PHPUnit_Result__
    normal! ggdG
    setlocal buftype=nofile
    call append(0, split(result, '\v\n'))
    cd -
endfunction

nnoremap <leader>r :call RunPHPUnitTest()<cr>
