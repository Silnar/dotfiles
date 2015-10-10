" Remove trailing whitespaces on write
if !exists("g:rc#strip_whitespace_on_write")
  let g:rc#strip_whitespace_on_write = 1
endif

function! Strip_whitespace_on_write()
  if g:rc#strip_whitespace_on_write
    StripWhitespace
  endif
endfunction

autocmd VimRC BufWritePre * :call Strip_whitespace_on_write()

" Blacklist
function! neobundle#tapped.hooks.on_post_source(bundle)
  let g:better_whitespace_filetypes_blacklist += ['log']
endfunction
