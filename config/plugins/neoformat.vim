
let g:neoformat_enabled_python = ['black']
let g:neoformat_python_black = {
      \ 'exe': 'black',
      \ 'stdin': 1,
      \ 'args': ['-q', '-'],
      \ }

let g:neoformat_enabled_lua = ['luaformatter']
let g:neoformat_lua_luaformatter = {
      \ 'exe': '/usr/local/bin/lua-format',
      \ 'stdin': 0,
      \ 'args': ['--column-limit=140', '--continuation-indent-width=2', '--tab-width=2', '--indent-width=2', '--column-table-limit=80',
      \          '--keep-simple-control-block-one-line', '--keep-simple-function-one-line', '--align-args', '--no-break-after-functioncall-lp', '--align-parameter',
      \          '--chop-down-parameter', '--no-break-after-functiondef-lp', '--no-break-before-functiondef-rp', '--align-table-field', '--break-after-table-lb',
      \          '--break-before-table-rb', '--chop-down-table', '--chop-down-kv-table', '--extra-sep-at-table-end', '--no-break-after-operator', '--no-break-before-functioncall-rp'
      \         ],
      \ }
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
