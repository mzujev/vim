
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
	else
		exec 'vert res 25'
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
	let l:tmp = has("gui_running") ? '/tmp/.'.expand("%:t").'.'.strftime("%s") : ''
	let l:suffix = has("gui_running") ? ' > '.l:tmp."'"  : '|xclip -i'
	let l:prefix = has("gui_running") ? "xterm -bg rgb:4B/51/62 -fg white -fa mono -fs 10 -T 'FvwmMsg' -e '" : ''

	call setreg('"',substitute(strtrans(@"),'\^@',' ','g'))

	if a:0 > 0
		call setreg('r',':!'.l:prefix.'grep --line-buffered -rn "" ' . l:dir . '* 2>/dev/null|fzf --query="'.@".'"|cut -d":" -f1,2'.l:suffix.'')
	else
		call setreg('r',':!'.l:prefix.'find ' . l:dir . ' 2>/dev/null|fzf|head -n1'.l:suffix.'')
	endif

	normal @r

	if has("gui_running")
"		call setreg('r',':!cat '.l:tmp.'|xclip -i && rm '.l:tmp.'')
"		normal @r
		let l:clip = system('cat '.l:tmp.' && rm '.l:tmp)
		let l:fname = split(substitute(l:clip,'\n$','',''),':')
	else
		let l:fname = split(Clip(),':')
	endif

	if get(l:fname,0) != '0'
		exec a:cmd . '! ' . l:fname[0]

		if get(l:fname,1) != '0'
			exec l:fname[1]
		endif
	endif

	call setreg('r',l:regr)
endfunc

func! Clip(...)
	let l:clip = system('xclip -o')
	if empty(l:clip)
		return
	endif
	return (a:0 > 0 ? a:1 . ' ' : '') . substitute(l:clip,'\n$','','')
endfunc

syntax on

if has("autocmd")
	autocmd BufReadPost *
<<<<<<< HEAD
				\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
				\ |   exe "normal! g`\""
				\ | endif
	if exists("+omnifunc")
		autocmd Filetype *
					\ if &omnifunc == "" |
					\   setlocal omnifunc=syntaxcomplete#Complete |
					\ endif
		set completeopt=longest,menuone
	endif
=======
		\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
		\ |   exe "normal! g`\""
		\ | endif
>>>>>>> 91e0d894efe90286ac7f9f951d698b6daa12fff0
endif

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

noremap <silent> <C-w>! :term<CR><C-w>J<C-w>:resize 5<CR>
inoremap <silent> <C-w>! <C-o>:term<CR><C-w>J<C-w>:resize 5<CR>

