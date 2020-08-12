if g:HasPlug('vista.vim')
  let g:vista_sidebar_width = 35
  let g:vista_fzf_preview = ['right:40%']
  let g:vista_keep_fzf_colors = 1
  let g:vista_sidebar_position = 'vertical topleft'
  let g:vista_echo_cursor_strategy = 'echo'

  let g:vista_ctags_cmd = {
        \ 'haskell': 'hasktags -x -o - -c',
        \ }
  " let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
  let g:vista#renderer#enable_icon = 1
  let g:vista_fold_toggle_icons = ['▼', '▶']
  "let g:vista_default_executive = 'ctags'
  let g:vista#renderer#icons = {
        \   "function": "\uf794",
        \   "variable": "\uf71b",
        \  }

  let g:vista_executive_for = {
      \ 'c': 'coc',
      \ 'cpp': 'coc',
      \ 'python': 'coc',
      \ 'php': 'coc',
      \ 'vimwiki': 'markdown',
      \ 'pandoc': 'markdown',
      \ 'markdown': 'toc',
      \ }

  let g:vista_finder_alternative_executives = ['clap']
  let g:vista_ignore_kinds = ["zsh"]
  " autocmd FileType vista,vista_kind nnoremap <buffer> <silent>/ :<c-u>call vista#finder#fzf#Run()<CR>
  " autocmd FileType vista,vista_kind nnoremap <buffer> <silent>/ <esc>:Vista finder clap<CR>

  nnoremap <leader>ta <esc>:Vista!!<CR>

  autocmd FileType vista,vista_kind setlocal nobuflisted

  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction
  set statusline+=%{NearestMethodOrFunction()}
endif
