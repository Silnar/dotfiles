if g:rc#plugin_define

NeoBundleLazy 'hewes/unite-gtags', {
      \  'autoload': {
      \    'unite_sources' : [
      \      'gtags/context',
      \      'gtags/ref',
      \      'gtags/def',
      \      'gtags/grep',
      \      'gtags/completion',
      \      'gtags/file'
      \    ],
      \  }
      \}

else


endif
