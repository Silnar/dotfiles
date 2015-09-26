if g:rc#plugin_define

  NeoBundleLazy 'vim-latex/vim-latex', {
        \  "autoload": {
        \    "filetypes": ['tex'],
        \  }
        \}

else

  " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
  " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
  " The following changes the default filetype back to 'tex':
  let g:tex_flavor='latex'

  let g:Tex_DefaultTargetFormat='pdf'
  let g:Tex_ViewRule_pdf='okular'

endif
