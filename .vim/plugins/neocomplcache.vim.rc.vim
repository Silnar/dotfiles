if g:rc#plugin_define

  if !(has('lua') && v:version >= 703)
    NeoBundleLazy 'Shougo/neocomplcache.vim', {
          \  'autoload' : {
          \    'insert' : 1,
          \  },
          \}
  endif

else

  function! neobundle#tapped.hooks.on_source(bundle)
    let g:neocomplcache_enable_smart_case = 1
  endfunction

endif
