if !has("neovim")
  NeoBundleLazy 'Rip-Rip/clang_complete', {
        \  "autoload": {
        \    "filetypes": ['c', 'cpp', 'objc', 'objcpp'],
        \  }
        \}
endif
