" Enable filetype plugin
filetype plugin on
filetype plugin indent on

" Syntax highlighting
syntax on

" Code completion
set omnifunc=syntaxcomplete#Complete

" Gui options
set guioptions=c

if has("gui_running")
  if has("gui_macvim")
    set guifont=Monaco:h14
  else
    set guifont=Fantasque\ Sans\ Mono\ Regular\ 14
    " set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
  endif
endif

" Enable mouse support on terminals
if has("mouse")
  set mouse=a
endif

" Assume fast terminal connection
if !has("nvim")
  set ttyfast
endif

" Colorscheme
if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:gruvbox_contrast_dark="hard"
  let g:gruvbox_italic=1
  set bg=dark
  colorscheme gruvbox
else
  set t_Co=256
  colorscheme mrkn256
  hi CursorLine term=NONE cterm=NONE gui=NONE
endif

" Highlight current line
set cursorline

" Show line numbers
set number

" Show file position
set ruler

" Show matching brackets
set showmatch
set matchtime=2

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Buffers
set autowrite
set hid

" Windows
set noequalalways
set laststatus=2
set splitbelow
set splitright

" Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Searching
set ignorecase
set smartcase
set incsearch
" set hlsearch

" Wild menu
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*~,*.pyc

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Persistence
set viminfo+=!

" Swap files
let s:swapDir = $HOME . "/.vimswap"
if !isdirectory(s:swapDir)
  call mkdir(s:swapDir)
endif

set directory-=.
let &directory = s:swapDir . '//,' . &directory

" Invisible symbols
set listchars=tab:▸\ ,eol:¬

" Statusline
" set statusline=%n\ %f%<
" set statusline+=\ %m%r%h%w%q
" set statusline+=%=
" set statusline+=%{fugitive#statusline()}
" set statusline+=\ %y
" set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
" set statusline+=[row:%l\ col:%v]

" Folding
" Based on: http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart(repeat(foldchar, (v:foldlevel-1)*2) . '▸' . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set fillchars=fold:\  " space
set foldtext=NeatFoldText()
