if has('lua') && v:version >= 703
  NeoBundleLazy 'Shougo/neocomplete.vim', {
        \  'autoload' : {
        \    'insert' : 1,
        \  },
        \}
endif
