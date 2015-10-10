"    _____ _ __
"   / ___/(_) /___  ____ ______
"   \__ \/ / / __ \/ __ `/ ___/
"  ___/ / / / / / / /_/ / /
" /____/_/_/_/ /_/\__,_/_/
"
" Silnar Vim Configuration
" useful links:
" - Favorite vim plugins & scripts: http://stackoverflow.com/questions/21725/favorite-gvim-plugins-scripts
" - http://amix.dk/vim/vimrc.html
" - http://statico.github.io/vim.html
" - http://www.vimninjas.com/2012/08/26/10-vim-color-schemes-you-need-to-own/
" - https://github.com/haya14busa/dotfiles/blob/master/.vimrc
"
" Usefull tricks:
" - http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
"
" TODO:
" - multiple cursors: https://github.com/terryma/vim-multiple-cursors
" - unite:
"   http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
" - gtags:
"   http://www.farseer.cn/config/2013/11/26/ctags-cscope-gtags/
" - ag, grep searching
" - move mappings to one place
" - https://github.com/bling/dotvim
"
" - Fix neco-ghc, vim-latex config - add tap, snippet?

" Startup {{{
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Echo startup time on starup
" if has('vim_starting') && has('reltime')
"   " Shell: vim --startuptime filename -q; vim filename
"   " Shell: vim --cmd 'profile start profile.txt' --cmd 'profile file $HOME/.vimrc' +q && vim profile.txt
"
"   let s:startuptime = reltime()
"   autocmd VimEnter * let s:startuptime = reltime(s:startuptime) | redraw
"   \ | echomsg 'startuptime: ' . reltimestr(s:startuptime)
" endif

" Load helper functions {{{
source ~/.vim/rc/functions.rc.vim
" }}}

let g:rc#os=GetRunningOS()

" Clear main augroup {{{
augroup VimRC
  autocmd!
augroup END
" }}}

" }}}

" Install NeoBundle if not available {{{
if ! isdirectory(expand('~/.vim/bundle'))
  echon "Installing neobundle.vim..."
  silent call mkdir(expand('~/.vim/bundle'), 'p')
  silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
  echo "done."
  if v:shell_error
    echoerr "neobundle.vim installation has failed!"
    finish
  endif
endif
" }}}

" Load NeoBundle plugin {{{
if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" }}}

" Load bundles {{{
call neobundle#begin(expand('~/.vim/bundle/'))

  if neobundle#load_cache()
    NeoBundleFetch 'Shougo/neobundle.vim'

    NeoBundleLocal ~/.vim/bundle-local/

    for file in split(globpath('~/.vim/rc/plugins/', '*.plugin.def.vim'), '\n')
      execute "source " . fnameescape(file)
    endfor

    NeoBundleSaveCache
  endif

call neobundle#end()
" }}}

" Load default settings {{{
source ~/.vim/rc/defaults.rc.vim
" }}}

" Filetype & Autocommand {{{
" Tabs
autocmd VimRC Filetype haskell setlocal ts=2 sts=2 sw=2 et ai
autocmd VimRC Filetype taskpaper setlocal ts=2 sts=2 sw=2 ai
" }}}

" Plugin settings {{{
let g:rc#plugin_define = 0
for file in split(globpath('~/.vim/rc/plugins/', '*.plugin.rc.vim'), '\n')
  let plugin_name = fnamemodify(file, ":t:s?.plugin.rc.vim??")

  if neobundle#tap(plugin_name)
    execute "source " . fnameescape(file)
    call neobundle#untap()
  endif
endfor
" }}}

" Mappings {{{

" Helpers {{{
" Example:
" RunUnite("Buffer", [['buffer']], 1, "search_string", "input"]
" RunUnite("Grep", [['grep', '.', '', '']], 0, "search_string", "param:0:3"]
function! RunUnite(bufname, sources, start_insert, text, text_dst)
  let input = ""
  let sources = a:sources

  if a:text_dst == 'input'
    let input = a:text
  elseif match(a:text_dst, "^param:") != -1
    let [_, srcIdx, paramIdx] = split(a:text_dst, ':')
    let sources[srcIdx][paramIdx] = a:text
  endif

  if a:start_insert
    let start_insert_arg = "-start-insert"
  else
    let start_insert_arg = ""
  endif

  let srcs = []
  for src in sources
    let escaped_src = map(src, "escape(v:val, ' ')")
    call add(srcs, join(escaped_src, ':'))
  endfor
  let src_arg = join(srcs, ' ')
  echo src_arg

  if len(input) > 0
    let input_arg = "-input=" . escape(input, ' ')
  else
    let input_arg = ""
  endif

  execute "Unite"
        \ "-buffer-name=" . a:bufname
        \ "-wipe"
        \ "-no-split"
        \ start_insert_arg
        \ input_arg
        \ src_arg
endfunction

function! UniteDefineTargetFunction(bufname, sources, start_insert, text_dst)
  if a:start_insert
    let fn_name = "Find" . a:bufname . "I"
  else
    let fn_name = "Find" . a:bufname
  endif

  execute "function! " . fn_name . "(text)\n"
        \ "let bufname = '" . a:bufname . "'\n"
        \ "let sources = " . string(a:sources) . "\n"
        \ "let start_insert = " . a:start_insert . "\n"
        \ "let text_dst = '" . a:text_dst . "'\n"
        \ "call RunUnite(bufname, sources, start_insert, a:text, text_dst)\n"
        \ "endfunction"
  return fn_name
endfunction

function! Define_Unite_Mapping(bufname, mapping_char, sources, text_dst)
  let fn_name_normal = UniteDefineTargetFunction(a:bufname, a:sources, 0, a:text_dst)
  execute "nnoremap <silent> <Leader>f" . a:mapping_char . " :<C-u>call " . fn_name_normal . "('')<CR>"
  call TextTransform#MakeMappings('<silent>', ",f" . a:mapping_char, fn_name_normal)

  let fn_name_start_insert = UniteDefineTargetFunction(a:bufname, a:sources, 1, a:text_dst)
  execute "nnoremap <silent> <Leader>F" . a:mapping_char . " :<C-u>call " . fn_name_start_insert . "('')<CR>"
  call TextTransform#MakeMappings('<silent>', ",F" . a:mapping_char, fn_name_start_insert)
endfunction
" }}}

let maplocalleader = "\\l"

nmap <silent> <Leader>t :tabnew<CR>
nmap <silent> <Leader>e :<C-u>VimFiler -toggle<CR>
nmap <silent> <Leader>E :<C-u>VimFilerExplorer -toggle<CR>
nmap <silent> <Leader>u :<C-u>GundoToggle<CR>
nmap <silent> <Leader>. :edit ~/.vimrc<CR>
nmap <silent> <Leader>> :source ~/.vimrc<CR>
nmap <silent> go :<C-u>FSHere<CR>

" nmap <silent> <Leader>f\ :<C-u>UniteResume<CR>
call Define_Unite_Mapping("Bookmark", "k", [['bookmark']], "input")
call Define_Unite_Mapping("Colorscheme", "h", [['colorscheme']], "input")
call Define_Unite_Mapping("File", "f", [['file_rec/async', '!']], "input")
call Define_Unite_Mapping("FileGit", "g", [['file_rec/git']], "input")
call Define_Unite_Mapping("FileMru", "u", [['file_mru']], "input")
call Define_Unite_Mapping("Outline", "o", [['outline']], "input")
call Define_Unite_Mapping("Snippet", "s", [['neosnippet']], "input")
call Define_Unite_Mapping("Fold", "z", [['fold']], "input")
call Define_Unite_Mapping("Jump", "j", [['jump']], "input")
call Define_Unite_Mapping("Buffer", "b", [['buffer']], "input")
call Define_Unite_Mapping("QuickFix", "q", [['quickfix']], "input")
call Define_Unite_Mapping("LocationList", "l", [['location_list']], "input")
call Define_Unite_Mapping("Tab", "t", [['tab']], "input")
call Define_Unite_Mapping("Window", "w", [['window']], "input")
call Define_Unite_Mapping("Command", "c", [['command']], "input")
call Define_Unite_Mapping("Mapping", "m", [['mapping']], "input")
call Define_Unite_Mapping("Function", "n", [['function']], "input")
call Define_Unite_Mapping("Register", "r", [['register']], "input")
call Define_Unite_Mapping("GrepLocal", "/", [['grep', '%', '-s', '']], "param:0:3")
call Define_Unite_Mapping("GrepLocalS", "?", [['grep', '%', '-i', '']], "param:0:3")
call Define_Unite_Mapping("GrepProject", ".", [['grep', '.', '-s', '']], "param:0:3")
call Define_Unite_Mapping("GrepProjectS", ">", [['grep', '.', '-i', '']], "param:0:3")
call Define_Unite_Mapping("Anything", "<Space>",
      \ [['file_rec/async', '!'], ['file_mru'], ['buffer'], ['bookmark'], ['outline'], ['fold']], "input")


" " Item info"
" au FileType haskell nmap <Leader>i :HdevtoolsInfo<CR>
" au FileType haskell nmap <Leader>t :HdevtoolsType<CR>
" au FileType haskell nmap <Leader>c :HdevtoolsClear<CR>

" Search and replace {{{

" Replace word under cursor
if exists(":OverCommandLine")
  nnoremap <Leader>S :<C-u>OverCommandLine %s/\<<C-R><C-W>\>/<CR>
else
  nnoremap <Leader>S :<C-u>%s/\<<C-R><C-W>\>/<CR>
endif

" Replace selected text
if exists(":OverCommandLine")
  vnoremap <Leader>s :<C-u>OverCommandLine %s/<C-R>=Get_visual_selection()<CR>/<CR>
else
  vnoremap <Leader>s :<C-u>%s/<C-R>=Get_visual_selection()<CR>/
endif

" Replace selected text (treat it as one word)
if exists(":OverCommandLine")
  vnoremap <Leader>S :<C-u>OverCommandLine %s/\<<C-R>=Get_visual_selection()<CR>\>/<CR>
else
  vnoremap <Leader>S :<C-u>%s/\<<C-R>=Get_visual_selection()<CR>\>/<CR>
endif
" }}}

" Commandline mappings {{{
cmap <C-a> <Home>
cmap <C-h> <Left>
cmap <C-l> <Right>
cmap <C-j> <Up>
cmap <C-k> <Down>
" }}}

" }}}

" Finally {{{
NeoBundleCheck

if !has('vim_starting')
  call neobundle#call_hook('on_source')
endif

set secure
" }}}

" vim:foldmethod=marker
