set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'JulesWang/css.vim'
Plugin 'groenewege/vim-less'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'fatih/vim-go'
Plugin 'ajh17/VimCompletesMe'

call vundle#end()

filetype on
filetype plugin on
filetype indent on

if has('mouse')
    set mouse=a
endif

syntax on
syntax enable

let mapleader = ','

set timeoutlen=200
set incsearch
set ignorecase
set smartcase
set scrolloff=10
set undolevels=100
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2
set number
set visualbell
set ruler
set viminfo='20,\"50
set history=100
set display+=lastline
set nobackup
set nowb
set noswapfile
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set omnifunc=syntaxcomplete#Complete

nmap <leader>m :set mouse=a<CR>
nmap <leader>M :set mouse=<CR>
nmap <leader>n :set number<CR>
nmap <leader>N :set nonumber<CR>
nmap <leader>p :set paste<CR>
nmap <leader>P :set nopaste<CR>
nmap <leader>h :set filetype=html<CR>
nmap <leader>H :set filetype=php<CR>
nmap <leader>t :tabnew

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
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = {'mode': 'active', 'passive_filetypes': ['go']}
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0
let g:jsx_ext_required = 0

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

autocmd BufNewFile,BufRead .eslintrc set filetype=json
autocmd BufNewFile,BufRead *.json set filetype=json
autocmd Filetype json setlocal ts=2 sts=2 sw=2

nnoremap <leader>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
nnoremap <leader>r :call RunPHPUnitTest()<cr>
