if g:HasPlug('vista.vim')
  let g:vista_sidebar_width = 35
  let g:vista_fzf_preview = ['right:40%']
  let g:vista_keep_fzf_colors = 1
  let g:vista_sidebar_position = 'vertical topleft'
  let g:vista_echo_cursor_strategy = 'echo'
  " let g:vista_update_on_text_changed = 1

  let g:vista_ctags_cmd = {
        \ 'haskell': 'hasktags -x -o - -c',
        \ }
  " let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
  let g:vista#renderer#enable_icon = 1
  " let g:vista_fold_toggle_icons = ['▼', '▶']
  let g:vista_echo_cursor = 1
  let g:vista#renderer#default#vlnum_offset = 3
  "let g:vista_default_executive = 'ctags'
  let g:vista#renderer#icons = {
        \   "function": "\uf794",
        \   "variable": "\uf71b",
        \  }

  let g:vista_executive_for = {
      \ 'c': 'ctags',
      \ 'cpp': 'coc',
      \ 'python': 'ctags',
      \ 'php': 'coc',
      \ 'rust': 'ctags',
      \ 'go': 'coc',
      \ 'lua': 'coc',
      \ 'vimwiki': 'markdown',
      \ 'pandoc': 'markdown',
      \ 'markdown': 'toc',
      \ }

  let g:vista_finder_alternative_executives = ['coc']
  let g:vista#executives = ['coc', 'ctags']
  let g:vista_ignore_kinds = ["zsh"]
  " autocmd FileType vista,vista_kind nnoremap <buffer> <silent>/ :<c-u>call vista#finder#fzf#Run()<CR>
  " autocmd FileType vista,vista_kind nnoremap <buffer> <silent>/ <esc>:Vista finder clap<CR>

  nnoremap <leader>ta <esc>:Vista!!<CR>

  augroup user_plugin_vista
    autocmd!
    autocmd TabLeave * if &filetype == 'vista' | wincmd w | endif
    autocmd WinEnter * if &filetype == 'vista' && winnr('$') == 1 | q | endif
  augroup END

  autocmd FileType vista setlocal nobuflisted noswapfile nowrap

  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction
  set statusline+=%{NearestMethodOrFunction()}
endif
