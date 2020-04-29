
set nu
set nowrap
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

set listchars=tab:\|\ 

func! Mngr()
	if &filetype != "netrw"
		let g:netrw_chgwin=2

		exec 'Ve|vert res 25'
	endif
endfunc

func! Tree()
	if &filetype != "netrw"
		normal h
		call Mngr()
	else
		normal l
	endif
endfunc

func! FzF(cmd)
	let s:regr = @r

	let s:dir = input('Директория просмотра: ','.')

	call setreg('r',':!find ' . s:dir . ' 2>/dev/null|fzf|head -n1|xclip -i')

	normal @r
	call setreg('r',s:regr)
	exec Clip(a:cmd)
endfunc

func! Clip(...)
	let s:fname = system('xclip -o')
	if empty(s:fname)
		return
	endif
	return (a:0 > 0 ? a:1 . ' ' : '') . substitute(s:fname,'\n$','','')
endfunc

syntax on

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

let g:hl_matchit_enable_on_vim_startup=1

filetype plugin indent on
runtime macros/matchit.vim

noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

vnoremap <silent> <C-y> ""y:call system("xclip -i",getreg("\""))<CR>
noremap <silent> <F12> :call Tree()<CR>
inoremap <silent> <F12> <ESC>:call Tree()<CR>

noremap <C-f> :call FzF('e')<CR>
noremap <C-t> :call FzF('tabe')<CR>

