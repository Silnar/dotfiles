if g:rc#plugin_define

  NeoBundleLazy 'ujihisa/neco-ghc', {
        \  "autoload": {
        \    "filetypes": ['haskell'],
        \  }
        \}

else

  let g:necoghc_enable_detailed_browse = 1

endif
