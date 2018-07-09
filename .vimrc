set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Themes
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chriskempson/base16-vim'

" Auto-completion
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Linting/Formatting
Plugin 'editorconfig/editorconfig-vim'
Plugin 'w0rp/ale'

" Utility
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/MatchTagAlways'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'benmills/vimux'
Plugin 'tyewang/vimux-jest-test'
Plugin 'geekjuice/vim-mocha'

" Php
Plugin 'lvht/phpcd.vim'
Plugin 'docteurklein/php-getter-setter.vim'

" JavaScript
Plugin 'pangloss/vim-javascript'

" JSX/Flow
Plugin 'mxw/vim-jsx'
Plugin 'flowtype/vim-flow'

" TypeScript
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'

" *SS
Plugin 'JulesWang/css.vim'
Plugin 'groenewege/vim-less'
Plugin 'cakebaker/scss-syntax.vim'

" Go-Lang
Plugin 'fatih/vim-go'

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

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set undofile
set undodir=~/.vim/undo
set background=dark
set t_Co=256   " This is may or may not needed.
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
set omnifunc=syntaxcomplete#Complete
set noshowmode
set noruler
set noshowcmd
set laststatus=2

nmap <leader>n :set number<CR>
nmap <leader>N :set nonumber<CR>
nmap <leader>p :set paste<CR>
nmap <leader>P :set nopaste<CR>
nmap <leader>h :set filetype=html<CR>
nmap <leader>H :set filetype=php<CR>
nmap <leader>c :bdelete<CR>
nmap <leader>r :edit<CR>
nmap <Leader>t :call RunCurrentSpecFile()<CR>
nmap <Leader>s :call RunNearestSpec()<CR>
nmap <Leader>l :call RunLastSpec()<CR>
nmap <Leader>a :call RunAllSpecs()<CR>
nmap <C-f> :NERDTreeToggle<CR>

let g:javascript_plugin_flow = 1
let g:flow#autoclose = 1
let g:enable_bold_font = 0
let g:go_fmt_fail_silently = 0
let g:go_fmt_autosave = 1
let g:jsx_ext_required = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_spell=1
let g:airline_powerline_fonts=0
let g:airline_theme='base16_monokai'
let g:ulti_expand_or_jump_res = 0
let g:ctrlp_show_hidden = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize = 40
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let delimitMate_expand_cr = 1
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_scss_stylelint_options = '--custom-syntax postcss-scss'
" let g:ale_javascript_eslint_options = ''
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_autoclose_preview_window_after_insertion = 0
let g:ycm_autoclose_preview_window_after_completion = 0
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabClosePreviewOnPopupClose = 1
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<C-n>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"
let g:phpgetset_setterTemplate =
      \ "    \n" .
      \ "    /**\n" .
      \ "     * Set %varname%\n" .
      \ "     *\n" .
      \ "     * @param type $%varname%\n" .
      \ "     * @return $this\n" .
      \ "     */\n" .
      \ "    public function %funcname%($%varname%)\n" .
      \ "    {\n" .
      \ "        $this->%varname% = $%varname%;\n" .
      \ "    \n" .
      \ "        return $this;\n" .
      \ "    }"
let g:phpgetset_getterTemplate =
      \ "    \n" .
      \ "    /**\n" .
      \ "     * Get %varname%\n" .
      \ "     *\n" .
      \ "     * @return type\n" .
      \ "     */\n" .
      \ "    public function %funcname%()\n" .
      \ "    {\n" .
      \ "        return $this->%varname%;\n" .
      \ "    }"
let g:ale_linters = {
      \ 'typescript': ['tslint'],
      \ 'javascript': ['eslint'],
      \ 'scss': ['stylelint'],
      \ 'php': ['phpcs'],
      \}

autocmd BufNewFile,BufRead .eslintrc set filetype=json
autocmd BufNewFile,BufRead .babelrc set filetype=json
autocmd BufNewFile,BufRead .stylelintrc set filetype=json
autocmd BufNewFile,BufRead .editorconfig set filetype=json
autocmd BufNewFile,BufRead *.json set filetype=json
autocmd BufNewFile,BufRead *.twig set filetype=html
autocmd FileType json setlocal ts=2 sts=2 sw=2
autocmd FileType * setlocal comments-=:// comments+=f://

nnoremap <C-n> :bnext<CR>
nnoremap <C-b> :bprevious<CR>
