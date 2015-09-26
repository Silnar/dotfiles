if g:rc#plugin_define

  NeoBundleLazy 'Shougo/unite.vim', {
        \  'commands' : [
        \    { 'name' : 'Unite',
        \      'complete' : 'customlist,unite#complete_source'},
        \    { 'name' : 'UniteBookmarkAdd' }],
        \  'depends' : 'Shougo/neomru.vim',
        \}

else

  let g:unite_source_grep_max_candidates = 200

  if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
          \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
          \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('pt')
    " Use pt in unite grep source.
    " https://github.com/monochromegane/the_platinum_searcher
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('ack-grep')
    " Use ack in unite grep source.
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts =
          \ '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
  endif

endif
