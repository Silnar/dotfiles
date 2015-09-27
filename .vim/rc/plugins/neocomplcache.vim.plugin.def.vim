if !(has('lua') && v:version >= 703)
  NeoBundleLazy 'Shougo/neocomplcache.vim', {
        \  'autoload' : {
        \    'insert' : 1,
        \  },
        \}
endif
