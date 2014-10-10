" Silnar Vim Configuration
" useful links:
" - Favorite vim plugins & scripts: http://stackoverflow.com/questions/21725/favorite-gvim-plugins-scripts
" - http://amix.dk/vim/vimrc.html
" - http://statico.github.io/vim.html
" - http://www.vimninjas.com/2012/08/26/10-vim-color-schemes-you-need-to-own/

" Packages {{{
set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'


NeoBundle 'morhetz/gruvbox'
" NeoBundle 'zeis/vim-kolor'
" NeoBundle 'Zenburn'
" NeoBundle 'synic.vim'
NeoBundle 'github-theme'
" NeoBundle 'altercation/vim-colors-solarized'
" NeoBundle 'twilight'
" NeoBundle 'Wombat'
" NeoBundle 'noctu.vim'
" NeoBundle 'vylight'
" NeoBundle 'vydark'

NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tommcdo/vim-exchange'
NeoBundle 'Gundo'
NeoBundle 'godlygeek/tabular'

NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'honza/vim-snippets'
NeoBundleLazy 'Rip-Rip/clang_complete'

NeoBundle 'Tagbar'
NeoBundle 'Syntastic'
NeoBundle 'tComment'
NeoBundle 'tpope/vim-fugitive'

NeoBundleLazy 'taskpaper.vim'
NeoBundleLazy 'bitc/vim-hdevtools'
NeoBundleLazy 'ujihisa/neco-ghc'
NeoBundleLazy 'bitc/lushtags'

au FileType c,cpp,objc,objcpp NeoBundleSource clang_complete
au FileType haskell NeoBundleSource vim-hdevtools neco-ghc lushtags
au FileType taskpaper NeoBundleSource taskpaper.vim
" }}}

" Vim options {{{
" Filetype detection
filetype plugin indent on

" Syntax highlighting
syntax on

" Code completion
set omnifunc=syntaxcomplete#Complete

" Gui options
set guioptions=

if has("gui_running")
  if has("gui_macvim")
    set guifont=Monaco:h12
    set noantialias
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
  endif
endif

" Enable mouse support on terminals
if has("mouse")
  set mouse=a
endif

" Colorscheme
colorscheme gruvbox
set background=dark

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
set statusline=%n\ %f%<
set statusline+=\ %m%r%h%w%q
set statusline+=%=
set statusline+=%{fugitive#statusline()}
set statusline+=\ %y
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=[row:%l\ col:%v]

" Folding
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

set foldtext=NeatFoldText()
" }}}

" Global mappings {{{
" Unite
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]

nnoremap <silent> [unite]f :<C-u>Unite -default-action=lcd bookmark<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]p :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <silent> [unite]r :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:.<CR>

" Explore
nmap <Leader>e :VimFilerExplorer<CR>

" Outline
nmap <Leader>o :TagbarToggle<CR>

" Run Gundo
nmap <Leader>u :GundoToggle<CR>

" Open new tab
nmap <Leader>t :tabnew<CR>

" Write file
nmap <C-S> :w<CR>
nmap <Leader>w :w<CR>

" Hide search highlight
nmap <Leader>h :set hlsearch!<CR>

" Show invisibles
nmap <leader>l :set list!<CR>

" Set background
nmap <Leader>bd :set background=dark<CR>
nmap <Leader>bl :set background=light<CR>

" Edit preferences
nmap <Leader>. :edit ~/.vimrc<CR>
nmap <Leader>> :source ~/.vimrc<CR>

" Substitute word under cursor
nmap <Leader>r :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader>r "hy:%s/<C-r>h//gc<left><left><left>

" " Item info
" au FileType haskell nmap <Leader>i :HdevtoolsInfo<CR>
" au FileType haskell nmap <Leader>t :HdevtoolsType<CR>
" au FileType haskell nmap <Leader>c :HdevtoolsClear<CR>

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

" Filetype & Autocommand {{{
" Tabs
autocmd Filetype haskell setlocal ts=2 sts=2 sw=2 et ai
autocmd Filetype taskpaper setlocal ts=2 sts=2 sw=2 ai

" Remove trailing whitespaces on write
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" VimFiler {{{
let g:vimfiler_as_default_explorer = 1

" Enable file operation commands.
"let g:vimfiler_safe_mode_by_default = 0

" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

autocmd FileType vimfiler nmap <buffer><silent> <Enter>
      \ :<C-u>execute "normal " . vimfiler#mappings#smart_cursor_map(
      \  "\<Plug>(vimfiler_cd_file)",
      \  "\<Plug>(vimfiler_edit_file)")<CR>

autocmd FileType vimfiler nmap <buffer><silent> <2-LeftMouse> :call <SID>vimfiler_on_double_click()<CR>
function! s:vimfiler_on_double_click() "{{{
  let context = vimfiler#get_context()

  if context.explorer
    let mapping = vimfiler#mappings#smart_cursor_map(
          \ "\<Plug>(vimfiler_expand_tree)",
          \ "\<Plug>(vimfiler_edit_file)"
          \ )
  else
    let mapping = vimfiler#mappings#smart_cursor_map(
          \ "\<Plug>(vimfiler_cd_file)",
          \ "\<Plug>(vimfiler_edit_file)"
          \ )
  endif

  execute "normal " . mapping
endfunction"}}}

let s:vimfilerexplorer = {
      \ 'description' : 'open vimfiler explorer here',
      \ }
function! s:vimfilerexplorer.func(candidate) "{{{
  if !exists(':VimFilerExplorer')
    echo 'vimfiler is not installed.'
    return
  endif

  if !s:check_is_directory(a:candidate.action__directory)
    return
  endif

  execute 'VimFilerExplorer' escape(a:candidate.action__directory, '\ ')

  if has_key(a:candidate, 'action__path')
        \ && a:candidate.action__directory !=# a:candidate.action__path
    " Move cursor.
    call vimfiler#mappings#search_cursor(a:candidate.action__path)
    call s:move_vimfiler_cursor(a:candidate)
  endif
endfunction"}}}

function! s:move_vimfiler_cursor(candidate) "{{{
  if &filetype !=# 'vimfiler'
    return
  endif

  if has_key(a:candidate, 'action__path')
        \ && a:candidate.action__directory !=# a:candidate.action__path
    " Move cursor.
    call vimfiler#mappings#search_cursor(a:candidate.action__path)
  endif
endfunction"}}}

function! s:check_is_directory(directory) "{{{
  if !isdirectory(a:directory)
    let yesno = input(printf(
          \ 'Directory path "%s" is not exists. Create? : ', a:directory))
    redraw
    if yesno !~ '^y\%[es]$'
      echo 'Canceled.'
      return 0
    endif

    call mkdir(a:directory, 'p')
  endif

  return 1
endfunction
"}}}

call unite#custom#action('cdable', 'vimfilerexplorer', s:vimfilerexplorer)
" }}}

" TComment {{{
let g:tcomment#replacements_c = {
            \     '/*': '#<{(|',
            \     '*/': '|)}>#',
            \ }
let g:tcommentLineC = {
            \ 'commentstring': '// %s',
            \ 'replacements': g:tcomment#replacements_c
            \ }
" }}}

" Go {{{
set rtp+=$GOROOT/misc/vim
" }}}

" Neo Complete {{{
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" }}}

" Neco-GHC {{{
let g:necoghc_enable_detailed_browse = 1
" }}}

" Neo Snippet {{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}

" Clang Complete {{{
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
"let g:clang_use_library = 1
" }}}

" vim:foldmethod=marker
