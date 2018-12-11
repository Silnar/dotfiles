setlocal foldcolumn=1

function! smarty_bot_log#folds()
  let thisline = getline(v:lnum)
  if match(thisline, '^\d\{2}:\d\{2}:\d\{2}\.\d\{3} ') >= 0
    return ">1"
  else
    return "="
  endif
endfunction
setlocal foldmethod=expr
setlocal foldexpr=smarty_bot_log#folds()

function! smarty_bot_log#fold_text()
  return getline(v:foldstart)
endfunction
setlocal foldtext=smarty_bot_log#fold_text()
