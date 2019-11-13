
set nu
set nowrap
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

set listchars=tab:\|\ 

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
noremap <silent> <F12> :if &filetype != "netrw"<CR>Ve<CR>vert res 25<CR>let g:netrw_chgwin=2<CR>else<CR>85Ve!<CR>bn<CR>endif<CR><CR>
inoremap <silent> <F12> <ESC>:Ve<CR>:vert res 25<CR>:let g:netrw_chgwin=2<CR>
