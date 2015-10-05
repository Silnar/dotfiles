if !has('nvim') && has('lua') && v:version >= 703
  NeoBundleLazy 'Shougo/neocomplete.vim', {
        \  'autoload' : {
        \    'insert' : 1,
        \  },
        \}
endif
