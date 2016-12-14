function! neobundle#tapped.hooks.on_post_source(bundle)
  " Switch to prev/next tab
  nmap <silent> [t gT
  nmap <silent> ]t gt

  " Move tab backward/forward
  nnoremap <silent> [T :tabmove -1<CR>
  nnoremap <silent> ]T :tabmove +1<CR>
endfunction
