command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

nnoremap <leader>bd <esc>:Bclose<CR>
nnoremap <leader>bo <esc>:bufdo :Bdelete<CR>
