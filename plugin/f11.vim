" f11.vim - helper plugin to manage gvim position and size while toggling
" fullscreen via <F11>
" Maintainer:   Ole Hansen 

if exists("g:loaded_f11")
	finish
endif
let g:loaded_f11 = 1

" Plugin {{{1
let g:f11FullScr = 0
let g:f11Lines = &lines
let g:f11Columns = &columns
let g:winSize = '0 0'

function! f11#saveWindow()
	let g:winSize = getwinposx() . ' ' . getwinposy()
endfunction

function! f11#restoreWindow()
	let sizepos = split(g:winSize)
	if len(sizepos) == 2
		execute "winpos ".sizepos[0]." ".sizepos[1]
	endif
endfunction

function! f11#TogFS()
	if g:f11FullScr == 0
		let g:f11Lines = &lines
		let g:f11Columns = &columns
		call f11#saveWindow()
		let g:f11FullScr = 1
		let &showtabline=0
	else
		let g:f11FullScr = 0
	endif
	call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
	if g:f11FullScr == 0
		let &lines = g:f11Lines
		let &columns = g:f11Columns
		call f11#restoreWindow()
		let &showtabline=1
	endif
endfunction

" Mappings {{{1
nnoremap <silent> <Plug>F11ToggleFullscreen :<C-U>call f11#TogFS()<CR>
inoremap <silent> <Plug>F11ToggleFullscreen :<C-U>call f11#TogFS()<CR>
vnoremap <silent> <Plug>F11ToggleFullscreen :<C-U>call f11#TogFS()<CR>

if !exists("no_plugin_maps") && !hasmapto('<Plug>F11ToggleFullscreen')
	call f11#togglemap("<F11>")
endif
