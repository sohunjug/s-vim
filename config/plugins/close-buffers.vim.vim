
" nnoremap <leader>bd <esc>:Bdelete this<CR>
nnoremap <leader>ba <esc>:Bdelete all<CR>
nnoremap <leader>bo <esc>:Bdelete other<CR>
nnoremap <leader>bi <esc>:Bdelete hidden<CR>
nnoremap <leader>bs <esc>:Bdelete select<CR>
nnoremap <leader>bm <esc>:Bdelete menu<CR>
nnoremap <leader>be <esc>:Bdelete nameless<CR>

" autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif

" autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val) && bufname(v:val) != "__vista" && bufname(v:val) != "[defx] defx-0"')) == 1 | quit | endif

" nn q :if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1) && expand('%') == '')<Bar>exe 'q'<Bar>else<Bar>exe 'bd'<Bar>endif<cr>
