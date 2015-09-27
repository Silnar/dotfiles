NeoBundleLazy 'Shougo/neosnippet.vim', {
      \  'depends' : [
      \    'Shougo/neosnippet-snippets',
      \    'Shougo/context_filetype.vim',
      \  ],
      \  'insert' : 1,
      \  'filetypes' : 'snippet',
      \  'commands' : ['NeoSnippetEdit'],
      \  'unite_sources' : [
      \    'neosnippet',
      \    'neosnippet/user',
      \    'neosnippet/runtime',
      \  ],
      \}
