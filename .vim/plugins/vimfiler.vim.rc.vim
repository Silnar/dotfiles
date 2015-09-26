if g:rc#plugin_define

  NeoBundleLazy 'Shougo/vimfiler.vim', {
        \   'autoload' : {
        \    'commands' : [
        \       { 'name' : 'VimFiler',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'VimFilerTab',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'VimFilerBufferDir',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'VimFilerExplorer',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'Edit',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'Write',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       'Read', 'Source'],
        \    'mappings' : '<Plug>(vimfiler_',
        \    'explorer' : 1,
        \   }
        \}

else

  function! neobundle#tapped.hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1

    " Enable file operation commands.
    " let g:vimfiler_safe_mode_by_default = 0

    " Like Textmate icons.
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_marked_file_icon = '*'

    autocmd VimRC FileType vimfiler nmap <silent><buffer> <2-LeftMouse> <Plug>(vimfiler_smart_l)
  endfunction

endif
