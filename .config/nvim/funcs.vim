function! CenterSearch()
	let cmdtype = getcmdtype()
	if cmdtype == '/' || cmdtype == '?'
		return "\<enter>zz"
	endif
	return "\<enter>"
endfunction
