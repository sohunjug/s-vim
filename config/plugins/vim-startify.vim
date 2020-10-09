" For startify
let g:startify_padding_left = 10
let g:startify_custom_header = [
\'                                                         ',
\'             ▄█    █▄   ▄█     ▄▄▄▄███▄▄▄▄      ▄████████',
\'            ███    ███ ███   ▄██▀▀▀███▀▀▀██▄   ███    ███',
\'            ███    ███ ███▌  ███   ███   ███   ███    █▀',
\'            ███    ███ ███▌  ███   ███   ███  ▄███▄▄▄',
\'            ███    ███ ███▌  ███   ███   ███ ▀▀███▀▀▀',
\'            ███    ███ ███   ███   ███   ███   ███    █▄',
\'            ███    ███ ███   ███   ███   ███   ███    ███',
\'             ▀██████▀  █▀     ▀█   ███   █▀    ██████████',
\'                                                         ',
\'                                                         ',
\]

let g:startify_files_number = 6
let g:startify_dir_number = 6
let g:startify_change_to_dir = 1

" session
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 0
let g:startify_session_dir = g:session_dir
let g:startify_session_sort = 1
" let g:startify_session_autoload = 1

" bookmarks 书签
let g:startify_bookmarks = [
            \ '~/Code/wiki/草稿/todo.md',
            \ '~/Code/wiki/草稿/快速笔记.md',
            \ '~/Code/dotfiles/.vim/config/plug.vim'
            \ ]

" command 命令
let g:startify_commands = [
    \ {'u': ['插件更新', 'PlugUpdate']},
    \ {'t': ['打开终端', 'terminal']},
    \ {'w': ['笔记列表', 'VimwikiIndex']},
    \ {'s': ['启动时间', 'StartupTime']},
    \ ]

let g:startify_lists = [
       \ { 'type': 'sessions',  'header': ['        Sessions']       },
       \ { 'type': 'bookmarks', 'header': ['        Bookmarks']      },
       \ { 'type': 'files',     'header': ['        MRU']            },
       \ { 'type': 'dir',       'header': ['        MRU '. getcwd()] },
       \ { 'type': 'commands',  'header': ['        Commands']       },
       \ ]

let g:startify_skiplist = [
       \ '\.vimgolf',
       \ '^/tmp',
       \ '^/Library',
       \ '^/Users/sohunjug/Library',
       \ '/project/.*/documentation',
       \ ]

let g:startify_session_before_save = [
        \ 'echo "Cleaning up before saving.."',
        \ 'silent! Vista!',
        \ 'silent! Defx -close!'
        \ ]

" 打开buffer也显示startify
" autocmd BufEnter *
"      \ if !exists('t:startify_new_tab') && empty(expand('%')) && !exists('t:goyo_master') |
"      \   let t:startify_new_tab = 1 |
"      \   Startify |
"      \ endif
autocmd VimEnter * :if argc() is 0 | Startify | endif

nnoremap <leader>bh <esc>:Startify<CR>
