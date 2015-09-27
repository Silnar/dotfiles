function! neobundle#tapped.hooks.on_post_source(bundle)
  " Force setting makeprg
  doautocmd FileType
endfunction
