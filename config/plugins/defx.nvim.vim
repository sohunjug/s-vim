if g:HasPlug('defx.nvim')

  let s:DefxWinNr = -1
  let s:beforWinnr = -1

  let s:openfloat = 0
  let s:openleft = 0
  autocmd FileType defx setlocal nobuflisted

  function! OpenDefx(search)
    let s:openleft = 1
    if a:search == 1 && g:HasPlug('vim-rooter')
      Rooter
      let s:root = g:FindRootDirectory()
      if len(s:root) > 0
        call defx#call_action('change_vim_cwd')
      endif
    endif
    exec 'wal'
    call defx#custom#option('_', {
          \ 'direction': 'botright',
          \ 'winwidth': 30,
          \ 'split': 'vertical',
          \ 'listed': 1,
          \ 'show_ignored_files': 0,
          \ 'buffer_name': 'defx',
          \ 'toggle': 1,
          \ 'resume': 1,
          \ 'columns': "mark:indent:git:icons:filename:size",
          \ 'ignored_files':
          \     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
          \   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.o,*.lo'
          \ })

    call defx#custom#column('mark', {
          \ 'selected_icon': '✓',
          \ 'readonly_icon': '',
          \ })
    if a:search == 0
      exec "Defx ".expand('%:p:h')
    else
      exec "Defx -search=".expand('%:p')
    endif

  endfunction

  " nnoremap <silent> <F2> <esc>:call OpenDefxCurWin()<cr>
  nnoremap <leader>ft <esc>:call OpenDefx(0)<cr>
  nnoremap <leader>fo <esc>:call OpenDefx(1)<cr>
  " nnoremap <silent> <leader>fo :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

  autocmd FileType defx call s:defx_custom_settings()

  " defx快捷键
  function! s:defx_custom_settings() abort
    nnoremap <silent><buffer><expr> <2-LeftMouse>    defx#do_action('call', 'DefxSmartL')
    nnoremap <silent><buffer><expr> N       defx#do_action('new_file')              " 新建文件/文件夹
    nnoremap <silent><buffer><expr> D       defx#do_action('remove')          " 删除
    nnoremap <silent><buffer><expr> Y       defx#do_action('copy')                  " 复制
    nnoremap <silent><buffer><expr> P       defx#do_action('paste')                 " 粘贴
    nnoremap <silent><buffer><expr> dd      defx#do_action('move')                  " 移动即剪切
    nnoremap <silent><buffer><expr> R       defx#do_action('rename')                " 重命名
    nnoremap <silent><buffer><expr> v       defx#do_action('toggle_select') . 'j'   " 选择
    nnoremap <silent><buffer><expr> V       defx#do_action('toggle_select') . 'k'   " 选择
    nnoremap <silent><buffer><expr> *       defx#do_action('toggle_select_all')     " 选择
    nnoremap <silent><buffer><expr> x       defx#do_action('execute_system')        " 执行
    nnoremap <silent><buffer><expr> yy      defx#do_action('yank_path')             " 复制路径
    nnoremap <silent><buffer><expr> q       defx#do_action('quit')
    nnoremap <silent><buffer><expr> h       defx#do_action('call', 'DefxSmartH')
    nnoremap <silent><buffer><expr> l       defx#do_action('call', 'DefxSmartL')
    nnoremap <silent><buffer><expr> L       defx#do_action('call', 'DefxSmartBigL')
    nnoremap <silent><buffer><expr> o       defx#do_action('call', 'DefxSmartO')
    nnoremap <silent><buffer><expr> <Cr>    defx#do_action('call', 'DefxSmartCr')
    if s:openleft
      nnoremap <silent><buffer><expr> sv      defx#do_action('drop', 'vsplit')
      nnoremap <silent><buffer><expr> sh      defx#do_action('drop', 'split')
      nnoremap <silent><buffer><expr> st      defx#do_action('drop', 'tabedit')
    endif
    nnoremap <silent><buffer><expr> S       defx#do_action('toggle_sort')           " 排序
    nnoremap <silent><buffer><expr> .       defx#do_action('toggle_ignored_files')  " 显示隐藏文件
    nnoremap <silent><buffer><expr> ~       defx#do_action('cd')
    nnoremap <silent><buffer><expr> !       defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> j       line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k       line('.') == 1 ? 'hhhG' : 'k'
    nnoremap <silent><buffer><expr> r       defx#do_action('redraw')
    nnoremap <silent><buffer><expr> `       defx#do_action('cd', getcwd())          " 回到工作目录
    nnoremap <silent><buffer><expr> cd      defx#do_action('change_vim_cwd')        " 将当前目录设置为工作目录
    nnoremap <silent><buffer><expr> s       defx#do_action('search', getcwd())
  endfunction

  function! DefxSmartCr(_)
    if defx#is_directory()
      call defx#call_action('open_directory')
      call defx#call_action('change_vim_cwd')
    else
      call defx#call_action('drop')
      " let a:filepath = defx#get_candidate()['action__path']
      " if s:openleft
      "     call defx#call_action('drop')
      " elseif s:openleft
      "     exec "close " . s:DefxWinNr
      "     exec s:beforWinnr . "wincmd w"
      "     exec 'e'. a:filepath
      " endif
    endif
  endfunction


  " in this function we should vim-choosewin if possible
  function! DefxSmartL(_)
    if defx#is_directory()
      call defx#call_action('open_tree')
      normal! j
    else
      let filepath = defx#get_candidate()['action__path']
      if tabpagewinnr(tabpagenr(), '$') >= 3    " if there are more than 2 normal windows
        if exists(':ChooseWin') == 2
          ChooseWin
        else
          let input = input('ChooseWin No./Cancel(n): ')
          if input ==# 'n' | return | endif
          if input == winnr() | return | endif
          exec input . 'wincmd w'
        endif
        exec 'e' filepath
      else
        exec 'wincmd w'
        exec 'e' filepath
      endif
    endif
  endfunction

  function! DefxSmartH(_)
    " if cursor line is first line, or in empty dir
    if line('.') ==# 1 || line('$') ==# 1
      return defx#call_action('cd', ['..'])
    endif

    " candidate is opend tree?
    if defx#is_opened_tree()
      return defx#call_action('close_tree')
    endif

    " parent is root?
    let s:candidate = defx#get_candidate()
    let s:parent = fnamemodify(s:candidate['action__path'], s:candidate['is_directory'] ? ':p:h:h' : ':p:h')
    let sep = g:isWindows ? '\\' :  '/'
    if s:trim_right(s:parent, sep) == s:trim_right(b:defx.paths[0], sep)
      return defx#call_action('cd', ['..'])
    endif

    " move to parent.
    call defx#call_action('search', s:parent)

    " if you want close_tree immediately, enable below line.
    call defx#call_action('close_tree')
  endfunction

  function! DefxYarkPath(_) abort
    let candidate = defx#get_candidate()
    let @+ = candidate['action__path']
    echo 'yanked: ' . @+
  endfunction

  function! s:trim_right(str, trim)
    return substitute(a:str, printf('%s$', a:trim), '', 'g')
  endfunction

  function! DefxSmartO(_)
    if s:openfloat
      if defx#is_directory()
        call defx#call_action('open_directory')
      else
        call defx#call_action('drop')
        exec "close " . s:DefxWinNr
      endif
    endif
  endfunction

  function! DefxSmartBigL(_)
    " exec 'wal'
    if defx#is_directory()
      call defx#call_action('open_tree_recursive')
      normal! j
    else
      let a:filepath = defx#get_candidate()['action__path']
      if s:openfloat
        exec "close " . s:DefxWinNr
      endif
      if tabpagewinnr(tabpagenr(), '$') >= 2    " if there are more than 2 normal windows
        if exists(':ChooseWin') == 2
          ChooseWin
        else
          if has('nvim')
            let input = input({
                  \ 'prompt'      : 'ChooseWin No.: ',
                  \ 'cancelreturn': 0,
                  \ })
            if input == 0 | return | endif
          else
            let input = input('ChooseWin No.: ')
          endif
          if input == winnr() | return | endif
          exec input . 'wincmd w'
        endif

        if &ft == 'defx'
          return
        else
          exec 'e' a:filepath
        endif

      else
        exec 'wincmd w'
        exec 'e' a:filepath
      endif
    endif
  endfunction

  call defx#custom#column('git', {
        \   'indicators': {
        \     'Modified'  : '•',
        \     'Staged'    : '✚',
        \     'Untracked' : 'ᵁ',
        \     'Renamed'   : '≫',
        \     'Unmerged'  : '≠',
        \     'Ignored'   : 'ⁱ',
        \     'Deleted'   : '✖',
        \     'Unknown'   : '⁇'
        \   }
        \ })

  let g:defx_icons_enable_syntax_highlight = 1
  let g:defx_icons_column_length = 2
  let g:defx_icons_directory_icon = ''
  let g:defx_icons_mark_icon = '*'
  let g:defx_icons_parent_icon = ''
  let g:defx_icons_default_icon = ''
  let g:defx_icons_directory_symlink_icon = ''
  " Options below are applicable only when using "tree" feature
  let g:defx_icons_root_opened_tree_icon = ''
  let g:defx_icons_nested_opened_tree_icon = ''
  let g:defx_icons_nested_closed_tree_icon = ''

  augroup user_plugin_defx
    autocmd!

    " FIXME
    " autocmd DirChanged * call s:defx_refresh_cwd(v:event)

    " Delete defx if it's the only buffer left in the window
    autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | q | endif

    " Move focus to the next window if current buffer is defx
    autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

    autocmd TabClosed * call s:defx_close_tab(expand('<afile>'))

    " Define defx window mappings
    "autocmd FileType defx call s:defx_mappings()

  augroup END

  function! s:defx_close_tab(tabnr)
    " When a tab is closed, find and delete any associated defx buffers
    for l:nr in range(1, bufnr('$'))
      let l:defx = getbufvar(l:nr, 'defx')
      if empty(l:defx)
        continue
      endif
      let l:context = get(l:defx, 'context', {})
      if get(l:context, 'buffer_name', '') ==# 'tab' . a:tabnr
        silent! execute 'bdelete '.l:nr
        break
      endif
    endfor
  endfunction
endif

