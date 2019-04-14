
set nu
set nowrap
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

vnoremap <silent> y ""y:call system("xclip -i",getreg("\""))<CR>

