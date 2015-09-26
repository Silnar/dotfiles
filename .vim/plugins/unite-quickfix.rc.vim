if g:rc#plugin_define

  NeoBundleLazy 'osyo-manga/unite-quickfix', {
        \  'autoload' : {
        \    'unite_sources' : [
        \      'quickfix',
        \      'location_list'
        \    ],
        \  }
        \}

else


endif
