if g:rc#plugin_define

  if executable("racer")
    NeoBundle 'racer-rust/vim-racer', {
          \  "autoload": {
          \    "filetypes": ['rust'],
          \  }
          \}
  endif

else

  let g:racer_cmd = "/usr/bin/racer"
  let $RUST_SRC_PATH="/usr/src/rust/src"

endif
