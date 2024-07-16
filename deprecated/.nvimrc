call plug#begin('~/.config/nvim/plugged')

" Theme
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'

" Linting/Formatting
Plug 'editorconfig/editorconfig-vim'

" Utility
Plug 'mileszs/ack.vim'
"Plug 'ap/vim-buftabline'
"Plug 'preservim/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
"Plug 'tpope/vim-fugitive'
"Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'

" js/ts
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Current extensions
" coc-tsserver
" coc-html
" coc-json
" coc-css
" coc-pairs
" coc-eslint

" Python
Plug 'janko/vim-test'

" *SS
Plug 'JulesWang/css.vim'
Plug 'groenewege/vim-less'
Plug 'cakebaker/scss-syntax.vim'
Plug 'othree/csscomplete.vim'

call plug#end()


let mapleader=','

if has('mouse')
  set mouse=a
endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  set termguicolors
  source ~/.vimrc_background
endif

if has('unix')
  set shell=/bin/bash
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

" Consistent timeout
set timeoutlen=200

" Better searching
set incsearch
set ignorecase
set smartcase
set nohlsearch

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
set hidden

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <esc> :noh<return><esc>
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
" LeaderF mappings
"noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
"noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
"noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
nmap <silent> <S-P> <Plug>(coc-refactor)
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
nnoremap <silent>  <S-B> :BufferPrevious<CR>
nnoremap <silent>  <S-N> :BufferNext<CR>
nnoremap <silent>  <S-C> :BufferClose<CR>
" NERDTree toggle
" nmap <C-f> :NERDTreeToggle<CR>
nmap <leader>g :Glow<CR>

nnoremap <C-f> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:coc_start_at_startup=1
let g:coc_data_home='~/.config/nvim/coc'

"let g:NERDTreeShowHidden=1
"let g:NERDTreeWinSize=40
"let g:NERDSpaceDelims=1
"let g:NERDDefaultAlign='left'
"let g:NERDTreeMinimalUI=1

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_DevIconsFont = "Hack Nerd Font Mono"
let g:Lf_StlColorScheme = 'base16-tomorrow-night'
let g:Lf_PopupColorscheme = 'base16-tomorrow-night'

let g:templates_debug = 1
let g:templates_no_autocmd = 1
let g:templates_directory = ['~/.config/templates']
let g:templates_name_prefix = '.vim-template:'

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" map prettier to coc-format
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Lint :CocCommand eslint.executeAutofix

nnoremap <S-L> :Prettier<cr>

" Better css autocomplete
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd User CocDiagnosticChange call lightline#update()
" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

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

let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

let g:lightline = {
  \ 'colorscheme': 'base16_tomorrow_night',
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

hi clear Spellbad
hi clear Error
hi clear Ignore

hi Error term=underline cterm=underline ctermfg=1 gui=underline guifg=#EC5F67
hi Ignore ctermfg=3 guifg=#FFCC00
hi Spellbad ctermfg=4 guifg=#FFCC00

lua << EOF
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 40,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

require('telescope').setup {
  defaults = { 
    file_ignore_patterns = {"node_modules"} 
  }
}
EOF
