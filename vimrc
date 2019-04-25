
set nu
set nowrap
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

filetype plugin indent on

vnoremap <silent> Y ""y:call system("xclip -i",getreg("\""))<CR>
noremap <silent> <F12> :if &filetype != "netrw"<CR>Ve<CR>vert res 25<CR>let g:netrw_chgwin=2<CR>else<CR>85Ve!<CR>bn<CR>endif<CR><CR>
inoremap <silent> <F12> <ESC>:Ve<CR>:vert res 25<CR>:let g:netrw_chgwin=2<CR>
