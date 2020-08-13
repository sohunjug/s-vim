command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

nnoremap <leader>bd <esc>:Bclose<CR>
nnoremap <leader>ba <esc>:bufdo :Bdelete<CR>
