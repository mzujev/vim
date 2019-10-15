
set fml=0
set fdm=indent

normal zR

fun! PlaceMarkers()
	let s:regx = @x
	let s:regr = @r
	
	call setreg('r','0v$hy0:s//\1\2\3\4#{\5/jzcopI#}}d$zR')
	
	normal zR

	global/\v^([\t| ]*[^\t| ]*[\t| ]*)<(if|else|elif|for|while|try|except|with|def|class)>(.*)(:)(\#|[^$]*)$/normal @r

	call setreg('x',s:regx)
	call setreg('r',s:regr)

	return
endfun

fun! RePlaceMarkers()
	let s:regx = @x
	let s:regr = @r

	call setreg('r',':s//\1\2\3:\5/')

	normal zR

	global/\v^([\t| ]*[^\t| ]*[\t| ]*)<(if|else|elif|for|while|try|except|with|def|class)>(.*)(:#\{)(\#|[^$]*)$/normal @r

	global/\v^[\t| ]*#\}/normal dd

	call setreg('x',s:regx)
	call setreg('r',s:regr)

	return
endfun

"autocmd BufWritePre <buffer> silent! call RePlaceMarkers()
"autocmd FilterWritePre <buffer> silent! call RePlaceMarkers()
"autocmd BufWritePost <buffer> silent! call PlaceMarkers()

"silent! call RePlaceMarkers()
"silent! call PlaceMarkers()

"inoremap :<CR> :#{<ESC>0v$hyo<ESC>pI#}}<ESC>d$O
