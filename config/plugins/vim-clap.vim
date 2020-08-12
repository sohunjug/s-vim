let g:clap_layout = { 'relative': 'editor' }
let g:clap_theme = 'material_design_dark'
" Change the CamelCase of related highlight group name to under_score_case.
" let g:clap_theme = { 'search_text': {'guifg': 'red', 'ctermfg': 'red'} }

" ref https://github.com/junegunn/fzf.vim/issues/379
function! s:SystemExecute(lines)
    for line in a:lines
        exec 'silent !xdg-open ' . fnameescape(line) . ' > /dev/null'
    endfor
endfunction
let g:clap_open_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit',
            \ 'ctrl-x': function('s:SystemExecute'),
\ }

function! s:ClapFiles() abort
    if &ft ==? 'vimwiki' && match(expand('%:p'), expand(g:vimwiki_path)) > -1
        exec "Clap files " . g:vimwiki_path
    else
        exec "Clap files"
    endif
endfunc

function! s:ClapGrep() abort
    if &ft ==? 'vimwiki' && match(expand('%:p'), expand(g:vimwiki_path)) > -1
        exec "Clap grep " . g:vimwiki_path
    else
        exec "Clap grep"
    endif
endfunc

nnoremap <leader>pf :call <SID>ClapFiles()<CR>
" nnoremap <M-F> :Clap files $HOME<CR>
nnoremap <leader>pb :Clap buffers<CR>
nnoremap <leader>pc :Clap command<CR>
nnoremap <leader>pt :Clap tags<CR>
nnoremap <leader>pT :Clap proj_tags<CR>
" 使用rg搜索工作目录
nnoremap <leader>ps :call <SID>ClapGrep()<CR>
" 模糊搜索所有buffer
nnoremap <leader>p? :Clap lines<CR>
nnoremap <leader>pr :Clap history<CR>
nnoremap <leader>pm :Clap marks<CR>
nnoremap <leader>pM :Clap maps<CR>
nnoremap <leader>pw :Clap windows<CR>
nnoremap <leader>py :Clap yanks<CR>
nnoremap <leader>pj :Clap jumps<CR>

nnoremap <leader>pq :Clap quickfix<CR>
nnoremap <leader>pl :Clap loclist<CR>

nnoremap <leader>ggd :Clap git_diff_files<CR>
nnoremap <leader>ggf :Clap gfiles<CR>
nnoremap <leader>ggm :Clap bcommits<cr>
nnoremap <leader>ggM :Clap commits<cr>
