" Silnar Vim Configuration
" useful links:
" - Favorite vim plugins & scripts: http://stackoverflow.com/questions/21725/favorite-gvim-plugins-scripts
" - http://amix.dk/vim/vimrc.html
" - http://statico.github.io/vim.html

" Vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'synic.vim'

Bundle 'unimpaired.vim'
Bundle 'surround.vim'
Bundle 'DfrankUtil'

Bundle 'ctrlp.vim'
Bundle 'The-NERD-tree'

Bundle 'vimprj'
Bundle 'Tagbar'
Bundle 'Syntastic'
Bundle 'tComment'
Bundle 'indexer.tar.gz'
Bundle 'fugitive.vim'

Bundle 'taskpaper.vim'
Bundle 'bitc/vim-hdevtools'
Bundle 'laurilehmijoki/haskellmode-vim.git'
" }}}

" Vim: Functions {{{
" http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
" }}}

" Vim: Behavior {{{
filetype plugin indent on

set autowrite
set noequalalways

" Don't redraw while executing macros (good performance config)
set lazyredraw

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" }}}

" Vim: Tabs {{{
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" }}}

" Vim: Tab settings per filetype {{{
autocmd Filetype haskell setlocal ts=2 sts=2 sw=2 et ai
autocmd Filetype taskpaper setlocal ts=2 sts=2 sw=2 ai
" }}}

" Vim: Searching {{{
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" For regular expressions turn magic on
set magic

" Makes search act like search in modern browsers
set incsearch
set ignorecase
set smartcase
set hlsearch
" }}}

" Vim: UI {{{
syntax on

if has("gui_running")
  colorscheme synic
else
  colorscheme elflord
  set bg=dark
endif

" Configure statusline
set statusline=%n\ %f%<
set statusline+=\ %m%r%h%w%q
set statusline+=%=
set statusline+=%{fugitive#statusline()}
set statusline+=\ %y
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=[row:%l\ col:%v]

"Always show current position
set ruler

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

set foldtext=NeatFoldText()

set laststatus=2

" Gui options
" set go-=T
" set go-=l
" set go-=L
" set go-=R
" set go-=r
" set go-=e
set guioptions=
set guifont=DejaVu\ Sans\ Mono\ 10
" }}}

" Vim: Wild menu {{{
" Turn on the Wild menu
set wildmenu
set wildmode=longest:full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
" }}}

" Vim: Tags {{{
set tags+=~/.vim/tags/c.tags
" }}}

" Vim: Remove trailing whitespaces on write {{{
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" Global mappings {{{
nmap <Leader>q :nohlsearch<CR>
nmap <leader>l :set list!<CR>

nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>o :TagbarToggle<CR>

nmap <Leader>. :edit ~/.vimrc<CR>
nmap <Leader>> :source ~/.vimrc<CR>

nmap <Leader>w :w<CR>
" }}}

" Commandline mappings {{{
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
" cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
" cnoremap <M-d>  <S-right><Delete>
" cnoremap <Esc>b <S-Left>
" cnoremap <Esc>f <S-Right>
" cnoremap <Esc>d <S-right><Delete>
" cnoremap <C-g>  <C-c>
" }}}

" CtrlP {{{
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|6|pyc|hi|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
" }}}

" TComment plugin {{{
let g:tcomment#replacements_c = {
            \     '/*': '#<{(|',
            \     '*/': '|)}>#',
            \ }
let g:tcommentLineC = {
            \ 'commentstring': '// %s',
            \ 'replacements': g:tcomment#replacements_c
            \ }
" }}}

" Tlist plugin {{{
" let Tlist_Ctags_Cmd = "/usr/bin/ctags"
" let Tlist_WinWidth = 40
" let Tlist_Use_Right_Window = 1
" let Tlist_Show_One_File = 1
" let Tlist_Compact_Format = 1
" let Tlist_Enable_Fold_Column = 0
"
" map <F4> :TlistToggle<cr>
" }}}

" Haskellmode plugin {{{
let g:haddock_browser = "/usr/bin/chromium"

au FileType haskell let b:ghc_staticoptions = '-isrc -itests'

autocmd Bufenter *.hs compiler ghc
autocmd BufWritePost *.hs GHCReload
" }}}

" Go plugin {{{
set rtp+=$GOROOT/misc/vim
" }}}

" Powerline plugin {{{
let g:powerline_config_overrides = {
\  'common': {
\    'dividers': {
\      'left': {
\        'hard': "▶ ",
\        'soft': "| ",
\      },
\      'right': {
\        'hard': " ◀",
\        'soft': " |",
\      }
\    },
\  }
\}
" }}}

" vim:foldmethod=marker
