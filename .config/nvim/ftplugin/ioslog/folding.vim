setlocal foldmethod=expr
setlocal foldexpr=folding#get_fold(v:lnum)
setlocal foldtext=folding#foldtext()
setlocal foldminlines=0

function! folding#foldtext()
	return getline(v:foldstart) . ' '
endfunction

function! folding#get_fold(lnum)
	" let log_entry_start_regexp = '^\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\.\(\d\{6}+\d\{4}\|\d\{3}\).*$'
	let log_entry_start_regexp = '^\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}.*$'
	let line = getline(a:lnum)
	let next_line = getline(a:lnum + 1)

	let line_is_log_entry_start = line =~# log_entry_start_regexp
	let next_line_is_log_entry_start = line =~# log_entry_start_regexp

	let log_entry_oneline = line_is_log_entry_start && next_line_is_log_entry_start
	let log_entry_multiline_start = line_is_log_entry_start && !next_line_is_log_entry_start
	let log_entry_multiline_middle = !line_is_log_entry_start && !next_line_is_log_entry_start
	let log_entry_multiline_end = !line_is_log_entry_start && next_line_is_log_entry_start

	if log_entry_oneline
		return '>1'
	elseif log_entry_multiline_start
		return '>1'
	elseif log_entry_multiline_middle
		return '='
	elseif log_entry_multiline_end
		return '<1'
	endif
endfunction
