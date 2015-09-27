function! neobundle#tapped.hooks.on_post_source(bundle)
  doautoall fugitive BufNewFile
endfunction
