
" 卸载不在列表中的插件
function! s:uninstall_unused_coc_extensions() abort
    for e in keys(json_decode(join(readfile(expand(g:coc_data_home . '/extensions/package.json')), "\n"))['dependencies'])
        if index(g:coc_global_extensions, e) < 0
            execute 'CocUninstall ' . e
        endif
    endfor
endfunction
autocmd User CocNvimInit call s:uninstall_unused_coc_extensions()

" 检查当前光标前面是不是空白字符
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" tab选择下一个补全
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<c-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

" shift tab 选择上一个补全
inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ "\<C-h>"

" alt j选择下一个补全
inoremap <silent><expr> <M-j>
    \ pumvisible() ? "\<C-n>" : return

" alt k选择上一个补全
inoremap <silent><expr> <M-k>
    \ pumvisible() ? "\<C-p>" : return

" 回车选中或者扩展选中的补全内容
if exists('*complete_info')
    " 如果您的（Neo）Vim版本支持，则使用`complete_info`
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" diagnostic 跳转
nmap <silent> <leader>en <Plug>(coc-diagnostic-next)
nmap <silent> <leader>ep <Plug>(coc-diagnostic-prev)

" 跳转到定义
" nmap <silent> gd :<c-u>call CocActionAsync('jumpDefinition')<cr>
nmap <silent> gd <plug>(coc-definition)
" 跳转到类型定义
nmap <silent> gy <plug>(coc-type-definition)
" 跳转到实现
nmap <silent> gi <plug>(coc-implementation)
" 跳转到引用
nmap <silent> gr <plug>(coc-references)

" 使用K悬浮显示定义
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" 函数文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
" 函数参数的文档
nnoremap <silent> <leader>ok :call CocActionAsync('showSignatureHelp')<CR>

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 格式化代码
command! -nargs=0 Format :call CocAction('format')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

" 文档块支持，比如删除条件，函数等
" 功能不如treesitter，使用treesitter
if !g:HasPlug('nvim-treesitter')
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)
endif

"""""""""""""""""""""""
" coc-plug config
"""""""""""""""""""""""
if g:HasPlug('coc-fzf')
    nnoremap <silent> <leader>oA  :<C-u>CocFzfList diagnostics<CR>
    nnoremap <silent> <leader>oa  :<C-u>CocFzfList diagnostics --current-buf<CR>
    nnoremap <silent> <leader>od  :<C-u>CocList --normal diagnostics<cr>
    nnoremap <silent> <leader>oc  :<C-u>CocFzfList commands<CR>
    nnoremap <silent> <leader>oe  :<C-u>CocFzfList extensions<CR>
    nnoremap <silent> <leader>ol  :<C-u>CocFzfList<CR>
    " nnoremap <silent> <leader>l  :<C-u>CocFzfList location<CR>
    nnoremap <silent> <leader>oo  :<C-u>CocFzfList outline<CR>
    nnoremap <silent> <leader>oO  :<C-u>CocFzfList symbols<CR>
    nnoremap <silent> <leader>os  :<C-u>CocFzfList services<CR>
    nnoremap <silent> <leader>or  :<C-u>CocFzfListResume<CR>

    if g:HasCocPlug('coc-yank')
        nnoremap <silent> <leader>oy  :<C-u>CocFzfList yank<CR>
    endif
else
    " Show all diagnostics
    if g:HasPlug('fzf-preview.vim')
        nnoremap <silent> <leader>oa  :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<cr>
        nnoremap <silent> <leader>oA  :<C-u>CocCommand fzf-preview.CocDiagnostics<cr>
    else
        nnoremap <silent> <leader>oa  :<C-u>CocList --normal diagnostics<cr>
    endif
    " Manage extensions
    " nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
    nnoremap <silent> <leader>oo  :<C-u>CocList --auto-preview outline<cr>
    nnoremap <silent> <leader>oO  :<C-u>CocList --auto-preview --interactive symbols<cr>
    " Show commands
    nnoremap <silent> <leader>oc  :<C-u>CocList commands<cr>
    " Resume latest coc list
    nnoremap <silent> <leader>or  :<C-u>CocListResume<CR>
    " nnoremap <silent> <leader>s  :<C-u>CocList services<CR>
    " show coclist 早晚要放进去的
    nnoremap <silent> <leader>ol  :<C-u>CocList<CR>
endif

" 重构refactor,需要lsp支持
nmap <leader>ot <Plug>(coc-refactor)
" 修复代码
nmap <leader>of  <Plug>(coc-fix-current)
" 变量重命名
nmap <leader>on <Plug>(coc-rename)

if !g:HasPlug("vim-visual-multi")
    " ctrl n下一个，ctrl p上一个
    " ctrl c 添加一个光标再按一次取消，
    nmap <silent> <C-c> <Plug>(coc-cursors-position)
    nmap <expr> <silent> <C-n> <SID>select_current_word()
    function! s:select_current_word()
        if !get(g:, 'coc_cursors_activated', 0)
            return "\<Plug>(coc-cursors-word)"
        endif
        return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
    endfunc

    xmap <silent> <C-n> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn
    nmap <silent> <C-a> :CocCommand document.renameCurrentWord<cr>

    " use normal command like `<leader>xi(`
    nmap <leader>ox  <Plug>(coc-cursors-operator)
endif

if g:HasCocPlug('coc-highlight')
    " 高亮当前光标下的所有单词
    au CursorHold * silent call CocActionAsync('highlight')
endif

function! CocListFilesWithWiki(query)
    if empty(a:query) && &ft ==? 'vimwiki'
        exec "CocList --no-sort files " . g:vimwiki_path
    else
        exec "CocList --no-sort files " . a:query
    endif
endfunction
" TODO 需要思考一下这里的逻辑
if !has('nvim') || !g:HasPlug('fzf.vim') && !g:HasPlug('LeaderF') && !g:HasPlug('vim-clap')
    if g:HasCocPlug('coc-lists')
        nnoremap <silent> <leader>fw :call CocListFilesWithWiki("")<CR>
        nnoremap <silent> <leader>fh :call CocListFilesWithWiki($HOME)<CR>
        nnoremap <silent> <leader>bb :CocList buffers<CR>
        nnoremap <silent> <leader>fvc :CocList vimcommands<CR>
        " tags, 需要先generate tags
        nnoremap <silent> <leader>tf :CocList tags<cr>
        nnoremap <silent> <leader>ps :CocList --auto-preview --interactive grep<cr>
        nnoremap <silent> <leader>? :CocList --auto-preview --interactive lines<cr>
        nnoremap <silent> <leader>fr :CocList mru -A<CR>
        nnoremap <silent> <leader>fm :CocList marks<CR>
        nnoremap <silent> <leader>fM :CocList maps<CR>
        nnoremap <silent> <leader>fw :CocList windows<CR>

    endif

    if g:HasCocPlug('coc-git')
        nnoremap <silent> <leader>gm :CocList bcommits<CR>
        nnoremap <silent> <leader>gM :CocList commits<CR>
    endif
endif

if g:HasCocPlug('coc-snippets')
    " alt j k 用于补全块的跳转
    let g:coc_snippet_next = '<c-j>'
    let g:coc_snippet_prev = '<c-k>'
endif

if g:HasCocPlug('coc-yank')
    " nnoremap <silent> <leader>y  :<C-u>CocList yank<cr>
    if !g:HasPlug('vim-clap') && !g:HasPlug('fzf')
        nnoremap <silent> <leader>fy  :<C-u>CocList yank<cr>
    endif
    call coc#config('yank.highlight.duration', 200)
    call coc#config('yank.enableCompletion', v:false)
endif

if g:HasCocPlug('coc-translator')
    nmap  <leader>ote <Plug>(coc-translator-e)
    nmap  <leader>otp <Plug>(coc-translator-p)
endif

if g:HasCocPlug('coc-bookmark')
    if !g:HasPlug('vim-bookmarks')
        call coc#config("bookmark.sign", "♥")
        nmap <silent> ma <Plug>(coc-bookmark-annotate)
        nmap <silent> mm <Plug>(coc-bookmark-toggle)
        nmap <silent> mj <Plug>(coc-bookmark-next)
        nmap <silent> mk <Plug>(coc-bookmark-prev)
        nmap <silent> mc :CocCommand bookmark.clearForCurrentFile<cr>
        nmap <silent> ml :CocList bookmark<cr>
    endif
endif

if g:HasCocPlug('coc-todolist')
    nmap <silent> <leader>otl :<C-u>CocList todolist<cr>
    nmap <silent> <leader>ota :<C-u>CocCommand todolist.create<cr>
endif

if g:HasCocPlug('coc-git')
    " 导航到修改块
    nmap <leader>gk <Plug>(coc-git-prevchunk)
    nmap <leader>gj <Plug>(coc-git-nextchunk)
    " 显示光标处的修改信息
    nmap <leader>gp <Plug>(coc-git-chunkinfo)
    nmap <leader>gu <esc>:CocCommand git.chunkUndo<cr>
endif

"--------------------------------- 自定义命令
" call coc#add_command('call CocAction("pickColor")', 'MundoToggle', '显示撤回列表')

"--------------------------------- 配置json文件

" coc-lists
if g:HasCocPlug("coc-lists")
    " session 保存目录
    call coc#config('session.directory', g:session_dir)
    if !g:HasPlug('dashboard-nvim')
        " 退出时自动保存session
        call coc#config('session.saveOnVimLeave', v:true)
    endif

    call coc#config('list.maxHeight', 10)
    call coc#config('list.maxPreviewHeight', 8)
    call coc#config('list.autoResize', v:false)
    call coc#config('list.source.grep.command', 'rg')
    call coc#config('list.source.grep.defaultArgs', [
                \ '--column',
                \ '--line-number',
                \ '--no-heading',
                \ '--color=always',
                \ '--smart-case'
            \ ])
    call coc#config('list.source.lines.defaultArgs', ['-e'])
    call coc#config('list.source.words.defaultArgs', ['-e'])
    call coc#config('list.source.files.command', 'rg')
    call coc#config('list.source.files.args', ['--files'])
    call coc#config('list.source.files.excludePatterns', ['.git'])
endif

" coc-clangd
if g:HasCocPlug('coc-clangd')
    " 配合插件vim-lsp-cxx-highlight实现高亮
    call coc#config('clangd.semanticHighlighting', v:true)
endif

" coc-kite
if g:HasCocPlug('coc-kite')
    call coc#config('kite.pollingInterval', 1000)
endif

" coc-xml
if g:HasCocPlug('coc-xml')
    call coc#config('xml.java.home', '/usr/lib/jvm/default/')
endif

" coc-prettier
if g:HasCocPlug('coc-prettier')
    call coc#config('prettier.tabWidth', 4)
endif

" coc-git
if g:HasCocPlug('coc-git')
    call coc#config('git.addGBlameToBufferVar', v:true)
    call coc#config('git.addGBlameToVirtualText', v:true)
    call coc#config('git.virtualTextPrefix', '  ➤  ')
    call coc#config('git.addedSign.hlGroup', 'GitGutterAdd')
    call coc#config('git.changedSign.hlGroup', 'GitGutterChange')
    call coc#config('git.removedSign.hlGroup', 'GitGutterDelete')
    call coc#config('git.topRemovedSign.hlGroup', 'GitGutterDelete')
    call coc#config('git.changeRemovedSign.hlGroup', 'GitGutterChangeDelete')
    call coc#config('git.addedSign.text', '▎')
    call coc#config('git.changedSign.text', '▎')
    call coc#config('git.removedSign.text', '▎')
    call coc#config('git.topRemovedSign.text', '▔')
    call coc#config('git.changeRemovedSign.text', '▋')
endif

" coc-snippets
if g:HasCocPlug('coc-snippets')
    call coc#config("snippets.ultisnips.enable", v:true)
    call coc#config("snippets.ultisnips.directories", [
                \ 'UltiSnips',
                \ 'gosnippets/UltiSnips'
            \ ])
    call coc#config("snippets.extends", {
                \ 'cpp': ['c'],
                \ 'typescript': ['javascript']
            \ })
endif


" coc-highlight
if g:HasCocPlug('coc-highlight')
    call coc#config("highlight.disableLanguages", ["csv"])
endif

" coc-rainbow-fart
if g:HasCocPlug('coc-rainbow-fart')
    call coc#config("rainbow-fart.ffplay", "ffplay")
endif

" coc-explorer
if g:HasCocPlug('coc-explorer')
    let g:coc_explorer_global_presets = {
        \   '.vim': {
        \      'root-uri': '~/.vim',
        \   },
        \   'floating': {
        \      'position': 'floating',
        \      'floating-position': 'center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \      'file-child-template': '[git | 2] [selection | clip | 1] [indent] [icon | 1] [diagnosticError & 1] [filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1] [timeCreated | 8] [size]'
        \   },
        \   'floatingTop': {
        \     'position': 'floating',
        \     'floating-position': 'center-top',
        \     'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingLeftside': {
        \      'position': 'floating',
        \      'floating-position': 'left-center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingRightside': {
        \      'position': 'floating',
        \      'floating-position': 'right-center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \   },
        \   'simplify': {
        \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
        \   }
    \ }

    " Use preset argument to open it
    nmap <leader>fvf :CocCommand explorer --preset floating ~/.vim<CR>
    if !g:HasPlug('ranger.vim')
        nmap <leader>fe :CocCommand explorer --preset floating<CR>
    endif

    " config
    call coc#config("explorer.icon.enableNerdfont", v:true)
    call coc#config("explorer.bookmark.child.template", "[selection | 1] [filename] [position] - [annotation]")
    " call coc#config("explorer.file.autoReveal", v:true)
    " call coc#config("explorer.keyMappingMode", "none")
      " "\ 'a': v:false,
    call coc#config("explorer.keyMappings", {
      \ 'k': 'nodePrev',
      \ 'j': 'nodeNext',
      \ 'h': 'collapse',
      \ 'l': ['expandable?', 'expand', 'open'],
      \ 'L': 'expandRecursive',
      \ 'H': 'collapseRecursive',
      \ 'K': 'expandablePrev',
      \ 'J': 'expandableNext',
      \ '<cr>': ['expandable?', 'cd', 'open'],
      \ '<bs>': 'gotoParent',
      \ 'r': 'refresh',
      \ 't': ['toggleSelection', 'normal:j'],
      \ 'T': ['toggleSelection', 'normal:k'],
      \ '*': 'toggleSelection',
      \ 'os': 'open:split',
      \ 'ov': 'open:vsplit',
      \ 'ot': 'open:tab',
      \ 'dd': 'cutFile',
      \ 'Y': 'copyFile',
      \ 'D': 'delete',
      \ 'P': 'pasteFile',
      \ 'R': 'rename',
      \ 'N': 'addFile',
      \ 'yp': 'copyFilepath',
      \ 'yn': 'copyFilename',
      \ 'gp': 'preview:labeling',
      \ 'x': 'systemExecute',
      \ 'f': 'search',
      \ 'F': 'searchRecursive',
      \ '<tab>': 'actionMenu',
      \ '?': 'help',
      \ 'q': 'quit',
      \ '<esc>': 'esc',
      \ 'gf': 'gotoSource:file',
      \ 'gb': 'gotoSource:buffer',
      \ '[[': 'sourcePrev',
      \ ']]': 'sourceNext',
      \ '[d': 'diagnosticPrev',
      \ ']d': 'diagnosticNext',
      \ '[c': 'gitPrev',
      \ ']c': 'gitNext',
      \ '<<': 'gitStage',
      \ '>>': 'gitUnstage'
    \ })


endif

call coc#config("languageserver", {
     \"ccls": {
     \  "enable": v:true,
     \  "command": "/usr/local/bin/ccls",
     \  "filetypes": ["rust", "python"],
     \  "rootPatterns": [".ccls", "compile_commands.json", "build/compile_commands.json", ".svn/", ".git/", "pyproject.toml", "packages.json"],
     \  "index": {
     \     "threads": 8
     \  },
     \  "initializationOptions": {
     \     "cache": {
     \       "directory": ".ccls-cache"
     \     },
     \     "compilationDatabaseDirectory": "build",
     \     "diagnostics": {
     \       "onChange": 5000,
     \     },
     \     "index": {
     \       "threads": 4,
     \     },
     \     "highlight": { "lsRanges" : v:true },
     \     "client": {
     \       "snippetSupport": v:true
     \     }
     \   },
     \}
     \})

" coc-python
if g:HasCocPlug('coc-python')
    call coc#config("python.jediEnabled", v:false)
    call coc#config("python.linting.enabled", v:true)
    call coc#config("python.linting.pylintEnabled", v:false)
    call coc#config("python.linting.flake8Enabled", v:true)
    call coc#config("python.venvPath", "~/.virtualenv")
    " call coc#config("python.venvFolders", [".venv","venv","~/.virtualenv"])
endif

