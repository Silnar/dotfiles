function! neobundle#tapped.hooks.on_source(bundle) "{{{
  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1

  " Remove snippets marker automatically
  " Autocmd InsertLeave * :NeoSnippetClearMarkers

  " Prioratise snippet
  " call neocomplete#custom#source('neosnippet', 'rank', 400)

  " snoremap <Esc> <Esc>:NeoSnippetClearMarkers<CR>
endfunction "}}}

let g:neosnippet#snippets_directory = "~/.vim/snippets"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"
