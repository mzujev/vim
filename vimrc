
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

func! FzF(cmd,...)
	let l:regr = @r
	let l:dir = input('Директория поиска: ','')

	if a:0 > 0
		call setreg('r',':!grep --line-buffered -rn "" ' . l:dir . '* 2>/dev/null | fzf --query=' .@".'|cut -d":" -f1,2|xclip -i')
	else
		call setreg('r',':!find ' . l:dir . ' 2>/dev/null|fzf|head -n1|xclip -i')
	endif

	normal @r

	call setreg('r',l:regr)

	let l:fname = split(Clip(),':')

	if get(l:fname,0) != '0'
		exec a:cmd . ' ' . l:fname[0]

		if get(l:fname,1) != '0'
			exec l:fname[1]
		endif
	endif
endfunc

func! Clip(...)
	let l:clip = system('xclip -o')
	if empty(l:clip)
		return
	endif
	return (a:0 > 0 ? a:1 . ' ' : '') . substitute(l:clip,'\n$','','')
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

vnoremap <C-f> ""y:call FzF('e','')<CR>
vnoremap <C-t> ""y:call FzF('tabe','')<CR>

inoremap <C-f> <C-o>:call FzF('e')<CR>
inoremap <C-t> <C-o>:call FzF('tabe')<CR>

