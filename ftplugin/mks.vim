
let g:session_file=expand('%:p')
let g:session_dir=expand('%:p:h')
let g:netrw_home = g:session_dir

source %

let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_curdir=g:session_dir
let g:netrw_bannerbackslash=1
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_chgwin=2
let g:netrw_hide=1

1bd

exe 'nnoremap <silent> <F2> :mks! ' . g:session_file . '<CR>:echohl WarningMsg<CR>:echo "Saved to -> ' . g:session_file . '"<CR>:echohl None<CR>'

