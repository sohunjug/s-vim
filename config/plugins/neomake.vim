scriptencoding utf-8
let s:neomake_automake_events = {}
" lint_on_save
let s:neomake_automake_events['BufWritePost'] = {'delay': 0}

" lint_on_the_fly
let s:neomake_automake_events['TextChanged'] = {'delay': 750}
let s:neomake_automake_events['TextChangedI'] = {'delay': 750}

if !empty(s:neomake_automake_events)
  try
    call neomake#configure#automake(s:neomake_automake_events)
  catch /^Vim\%((\a\+)\)\=:E117/
  endtry
endif
" 1 open list and move cursor 2 open list without move cursor
let g:neomake_open_list = 2
let g:neomake_verbose = 0
let g:neomake_java_javac_delete_output = 0
let g:neomake_error_sign = {
      \ 'text': '✖',
      \ 'texthl': 'GruvboxRedSign',
      \ }
let g:neomake_warning_sign = {
      \ 'text': '➤',
      \ 'texthl': 'GruvboxYellowSign',
      \ }
let g:neomake_info_sign = {
      \ 'text': '🛈',
      \ 'texthl': 'GruvboxYellowSign',
      \ }

let g:neoformat_enabled_python = ['black']
let g:neoformat_python_black = {
      \ 'exe': 'black',
      \ 'stdin': 1,
      \ 'args': ['-q', '-'],
      \ }

let g:neomake_c_enabled_makers = ['clang']
let g:neomake_cpp_enabled_makers = ['clang']

let g:neomake_c_clang_maker = {
   \ 'args': ['-Wall', '-Wextra', '-Weverything', '-pedantic'],
   \ }
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++',
   \ 'args': ['-Wall', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion'],
   \ }

let g:neoformat_enabled_toml = ['prettier']

let g:neoformat_cpp_clangformat = {
      \ 'exe': "clang-format",
      \ 'args': ['--style=Google'],
      \ }

let g:neoformat_enabled_cpp = ['clangformat']

autocmd FileType qf setlocal nobuflisted

" vim:set et sw=2:
