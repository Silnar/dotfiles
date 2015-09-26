if g:rc#plugin_define

  if !has("neovim")
    NeoBundleLazy 'Rip-Rip/clang_complete', {
          \  "autoload": {
          \    "filetypes": ['c', 'cpp', 'objc', 'objcpp'],
          \  }
          \}
  endif

else

  " disable auto completion for vim-clang
  let g:clang_auto = 0
  " default 'longest' can not work with neocomplete
  let g:clang_c_completeopt = 'menuone'
  let g:clang_cpp_completeopt = 'menuone'
  let g:clang_debug = 5 " use 1 for more debug
  let g:clang_exec = 'clang.exe'
  let g:clang_c_options = '-std=gnu11'
  let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  " for c and c++
  let g:neocomplete#force_omni_input_patterns.c =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
  let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  let g:neocomplete#force_omni_input_patterns.objc =
        \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)'
  let g:neocomplete#force_omni_input_patterns.objcpp =
        \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*'

  " if !exists('g:neocomplete#force_omni_input_patterns')
  "   let g:neocomplete#force_omni_input_patterns = {}
  " endif
  " let g:neocomplete#force_omni_input_patterns.c =
  "       \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
  " let g:neocomplete#force_omni_input_patterns.cpp =
  "       \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  " let g:neocomplete#force_omni_input_patterns.objc =
  "       \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)'
  " let g:neocomplete#force_omni_input_patterns.objcpp =
  "       \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*'
  " let g:clang_complete_auto = 0
  " let g:clang_auto_select = 0
  " "let g:clang_use_library = 1

endif
