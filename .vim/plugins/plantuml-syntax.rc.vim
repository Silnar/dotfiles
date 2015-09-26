if g:rc#plugin_define

  NeoBundleLazy 'aklt/plantuml-syntax', {
        \  "autoload": {
        \    "filetypes": ['plantuml'],
        \  }
        \}

else

  function! neobundle#tapped.hooks.on_post_source(bundle)
    " Force setting makeprg
    doautocmd FileType
  endfunction

endif
