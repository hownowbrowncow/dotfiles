call plug#begin('~/.vim/plugged')

" Themes
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'

" Linting/Formatting
Plug 'editorconfig/editorconfig-vim'

" Utility
Plug 'mileszs/ack.vim'
Plug 'ap/vim-buftabline'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

Plug 'yuezk/vim-js'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/jsonc.vim'

" Python
Plug 'janko/vim-test'

" *SS
Plug 'JulesWang/css.vim'
Plug 'groenewege/vim-less'
Plug 'cakebaker/scss-syntax.vim'
Plug 'othree/csscomplete.vim'

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

set nocompatible
set sessionoptions+=globals
set encoding=utf-8
set backspace=indent,eol,start
set nofoldenable

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
set nowritebackup
set nowb
set noswapfile

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> <S-Q> <Plug>(coc-definition)
nmap <silent> <S-W> <Plug>(coc-type-definition)
nmap <silent> <S-E> <Plug>(coc-implementation)
nmap <silent> <S-R> <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" map prettier to coc-format
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ],
      \
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'gitstatus' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'gitstatus': 'FugitiveStatusline',
      \ },
      \ }

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Number mode
nmap <leader>n :set number<CR>
nmap <leader>N :set nonumber<CR>

" Copy/Paste
nmap <leader>p :set paste<CR>
nmap <leader>P :set nopaste<CR>

" Buffers
nmap <S-C> :bdelete<CR>
nmap <S-N> :bnext<CR>
nmap <S-B> :bprevious<CR>

" NERDTree toggle
nmap <C-f> :NERDTreeToggle<CR>

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:coc_node_path='/Users/nick/.config/node/n/versions/node/12.16.3/bin/node'
let g:coc_data_home='/Users/nick/.config/coc'

let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let g:NERDTreeMinimalUI=1

" Set filetypes for non-standard files
autocmd BufNewFile,BufRead .eslintrc,.babelrc,.stylelintrc set filetype=json
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
" Better css autocomplete
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#(whoami)', '#(uptime | cut -d " " -f 1,2,3)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'x'    : '#(date)',
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : '#H'}

let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "~",
      \ "Staged"    : "+",
      \ "Untracked" : "-",
      \ "Renamed"   : "s",
      \ "Unmerged"  : "=",
      \ "Deleted"   : "x",
      \ "Dirty"     : "d",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : "i",
      \ "Unknown"   : "?"
      \ }

hi clear Spellbad
hi clear Error
hi clear Ignore

hi Error term=underline cterm=underline ctermfg=1 gui=underline guifg=#EC5F67
hi Ignore ctermfg=3 guifg=#FFCC00
hi Spellbad ctermfg=3 guifg=#FFCC00
