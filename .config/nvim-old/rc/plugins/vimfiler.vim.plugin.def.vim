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
