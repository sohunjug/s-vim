
let g:neoformat_enabled_python = ['black']
let g:neoformat_python_black = {
      \ 'exe': 'black',
      \ 'stdin': 1,
      \ 'args': ['-q', '-'],
      \ }

let g:neoformat_enabled_lua = ['luafmt']
let g:neoformat_lua_luafmt = {
      \ 'exe': '/usr/local/bin/luafmt',
      \ 'stdin': 1,
      \ 'args': ['-l', '140', '-i', '2', '--stdin'],
      \ }

let g:neoformat_enabled_toml = ['prettier']

let g:neoformat_cpp_clangformat = {
      \ 'exe': "clang-format",
      \ 'args': ['--style=Google'],
      \ }

let g:neoformat_enabled_cpp = ['clangformat']

let g:neoformat_enabled_java = ['googlefmt']
let g:neoformat_java_googlefmt = {
      \ 'exe': 'java',
      \ 'args': ['-jar', '-'],
      \ 'stdin': 1,
      \ }

nnoremap <leader>bf <esc>:Neoformat<CR>
