
set undofile
set undodir=$HOME/.cache/vimundo
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 3
endif

nnoremap <leader>ut :UndotreeToggle<cr>
