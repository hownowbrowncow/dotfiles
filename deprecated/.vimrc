call plug#begin('~/.vim/plugged')

" Theme
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'

" Linting/Formatting
Plug 'editorconfig/editorconfig-vim'

" Utility
Plug 'mileszs/ack.vim'
Plug 'ap/vim-buftabline'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'


" js/ts
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
	set termguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
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
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
nmap <silent> <S-P> <Plug>(coc-refactor)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-P> <Plug>(coc-refactor)
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> <S-Q> <Plug>(coc-definition)
nmap <silent> <S-W> <Plug>(coc-type-definition)
nmap <silent> <S-E> <Plug>(coc-implementation)
nmap <silent> <S-R> <Plug>(coc-references)
" Number mode
nmap <leader>n :set number<CR>
nmap <leader>N :set nonumber<CR>
" Copy/Paste
nmap <leader>p :set paste<CR>
nmap <S-F> :set nopaste<CR>
" Buffers
nmap <S-C> :bdelete<CR>
nmap <S-N> :bnext<CR>
nmap <S-B> :bprevious<CR>
" NERDTree toggle
nmap <C-f> :NERDTreeToggle<CR>

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:coc_start_at_startup=1
let g:coc_node_path='/Users/nick/.config/node/n/versions/node/12.16.3/bin/node'
let g:coc_data_home='/Users/nick/.config/coc'

let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let g:NERDTreeMinimalUI=1

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" map prettier to coc-format
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -complete=dir FzfSrc
  \ call fzf#vim#files(getcwd().'/src', fzf#vim#with_preview({'dir': getcwd().'/src', 'options': ['--info=inline']}), <bang>0)
command! -complete=dir FzfRoot
  \ call fzf#vim#files(getcwd(), fzf#vim#with_preview({'dir': getcwd(), 'options': ['--info=inline']}), <bang>0)

nnoremap <C-g> :FzfSrc<cr>
nnoremap <C-a> :FzfRoot<cr>

" Set filetypes for non-standard files
autocmd BufNewFile,BufRead .eslintrc,.babelrc,.stylelintrc set filetype=json
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
" Better css autocomplete
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd User CocDiagnosticChange call lightline#update()

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? branch : ''
  endif
  return 'no branch detected'
endfunction

function! CocLineError() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return ''| endif

  if (get(info, 'error', 0) == 0)
    return ''
  endif

  return 'E: ' . get(info, 'error', 0)
endfunction

function! CocLineInfo() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return ''| endif

  if (get(info, 'information', 0) == 0)
    return ''
  endif

  return 'I: ' . get(info, 'information', 0)
endfunction

function! CocLineWarn() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return ''| endif

  if (get(info, 'warning', 0) == 0)
    return ''
  endif

  return 'W: ' . get(info, 'warning', 0)
endfunction

function! CocLineStatus() abort
  let status = get(g:, 'coc_status', 0)
  if empty(status) | return '' | endif

  return status
endfunction

let g:lightline = {
  \ 'colorscheme': 'monokai',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'cocstatus', 'readonly', 'filename' ], [ 'cocerror', 'cocwarn', 'cocinfo' ] ],
  \   'right': [ [ 'fileformat', 'fileencoding', 'filetype' ], [ 'branch' ] ],
  \   },
  \ 'component_expand': {
  \   'cocerror': 'CocLineError',
  \   'cocwarn': 'CocLineWarn',
  \   },
  \  'component_type': {
  \    'cocerror': 'error',
  \    'cocwarn': 'warning',
  \   },
  \ 'component_function': {
  \   'cocinfo': 'CocLineInfo',
  \   'cocstatus': 'CocLineStatus',
  \   'branch': 'LightlineFugitive',
  \   },
  \ }

let g:tmuxline_preset = {
  \'a': '#S',
  \'c': ['#(whoami)', '#(uptime | cut -d " " -f 1,2,3)'],
  \'win': ['#I', '#W'],
  \'cwin': ['#I', '#W', '#F'],
  \'x': '#(date)',
  \'y': ['%R', '%a', '%Y'],
  \'z': '#H'
  \}

let g:NERDTreeIndicatorMapCustom = {
  \ "Modified": "~",
  \ "Staged": "+",
  \ "Untracked": "-",
  \ "Renamed": "s",
  \ "Unmerged": "=",
  \ "Deleted": "x",
  \ "Dirty": "d",
  \ "Clean" : "✔︎",
  \ 'Ignored': "i",
  \ "Unknown": "?"
  \ }
let g:fzf_colors = {
  \ 'fg': ['fg', 'Normal'],
  \ 'bg': ['bg', 'Normal'],
  \ 'hl': ['fg', 'Comment'],
  \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+': ['fg', 'Statement'],
  \ 'info': ['fg', 'PreProc'],
  \ 'border': ['bg', 'Repeat'],
  \ 'prompt': ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker': ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['bg', 'Comment']
  \}

hi clear Spellbad
hi clear Error
hi clear Ignore

hi Error term=underline cterm=underline ctermfg=1 gui=underline guifg=#EC5F67
hi Ignore ctermfg=3 guifg=#FFCC00
hi Spellbad ctermfg=4 guifg=#FFCC00
