if g:rc#plugin_define

  if has('lua') && v:version >= 703
    NeoBundleLazy 'Shougo/neocomplete.vim', {
          \  'autoload' : {
          \    'insert' : 1,
          \  },
          \}
  endif

else

  function! neobundle#tapped.hooks.on_source(bundle)
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#enable_underbar_completion = 1

    " Use fuzzy completion.
    let g:neocomplete#enable_fuzzy_completion = 1

    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    " Set auto completion length.
    let g:neocomplete#auto_completion_start_length = 2
    " Set manual completion length.
    let g:neocomplete#manual_completion_start_length = 0
    " Set minimum keyword length.
    let g:neocomplete#min_keyword_length = 3

    " Set neosnippet competion length.
    call neocomplete#custom#source('neosnippet', 'min_pattern_length', 1)

    let g:neocomplete#disable_auto_select_buffer_name_pattern =
          \ '\[Command Line\]'

    " Enable omni completion.
    " autocmd css setlocal omnifunc=csscomplete#CompleteCSS
    " autocmd html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    " autocmd javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    " autocmd javascript setlocal omnifunc=tern#Complete
    " autocmd coffee setlocal omnifunc=javascriptcomplete#CompleteJS
    " autocmd xml setlocal omnifunc=xmlcomplete#CompleteTags
    " autocmd python setlocal omnifunc=jedi#completions
  endfunction

  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1

  " Plugin key-mappings.
  " inoremap <expr><C-g>     neocomplete#undo_completion()
  " inoremap <expr><C-l>     neocomplete#complete_common_string()

  " <Tab>: completion
  " inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  " inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " <C-f>, <C-b>: page move.
  " inoremap <expr><C-f>  pumvisible() ? "\<PageDown>" : "\<Right>"
  " inoremap <expr><C-b>  pumvisible() ? "\<PageUp>"   : "\<Left>"
  " <C-y>: paste.
  " inoremap <expr><C-y>  pumvisible() ? neocomplete#close_popup() :  "\<C-r>\""
  " <C-e>: close popup.
  " inoremap <expr><C-e>  pumvisible() ? neocomplete#cancel_popup() : "\<End>"

endif
