if g:rc#plugin_define

NeoBundleLazy 'vim-scripts/gtags.vim', {
      \  'autoload': {
      \    'commands' : [
      \      { 'name' : 'Gtags' },
      \      { 'name' : 'GtagsCursor' }
      \    ],
      \  }
      \}

else


endif
