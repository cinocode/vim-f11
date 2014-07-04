function! f11#togglemap(mapActivation)
	try
		exe "silent! nmap <unique> ".a:mapActivation." <Plug>F11ToggleFullscreen"
		exe "silent! imap <unique> ".a:mapActivation." <Plug>F11ToggleFullscreen"
		exe "silent! vmap <unique> ".a:mapActivation." <Plug>F11ToggleFullscreen"
	finally
		return 0
	endtry
endfunction
