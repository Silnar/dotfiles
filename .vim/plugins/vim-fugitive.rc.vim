if g:rc#plugin_define

  NeoBundleLazy 'tpope/vim-fugitive', {
        \  'augroup': 'fugitive',
        \  'autoload': {
        \    'commands': [
        \      'Git',
        \      'Gcd',
        \      'Glcd',
        \      'Gstatus',
        \      'Gcommit',
        \      'Ggrep',
        \      'Glgrep',
        \      'Glog',
        \      'Gllog',
        \      'Gedit',
        \      'Gsplit',
        \      'Gvsplit',
        \      'Gtabedit',
        \      'Gpedit',
        \      'Gread',
        \      'Gwrite',
        \      'Gwq',
        \      'Gdiff',
        \      'Gsdiff',
        \      'Gvdiff',
        \      'Gmove',
        \      'Gremove',
        \      'Gblame',
        \      'Gbrowse'
        \    ]
        \  }
        \}

else

  function! neobundle#tapped.hooks.on_post_source(bundle)
    doautoall fugitive BufNewFile
  endfunction

endif
