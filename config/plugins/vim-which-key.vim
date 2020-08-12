" nnoremap <silent> <leader> :WhichKey '<leader>'<CR>

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=1 showmode ruler

let g:which_key_map = { 'name' : 'sohunjug-Vim' ,
      \ '-' : 'ChooseWin' ,
      \ '=' : 'Format' ,
      \ '*' : 'FzfSearchInBuf' ,
      \ '?' : 'FzfSearch' ,
      \ '.' : 'lcd .' }
let g:which_key_map.b = { 'name' : '+Buffers',
      \ 'b' : 'List' ,
      \ 'f' : 'Format' ,
      \ 'n' : 'Next' ,
      \ 'p' : 'Prev' ,
      \ 'd' : 'Close' ,
      \ 'D' : 'ForceClose' ,
      \ 'h' : 'Startify' ,
      \ 'r' : 'Return' ,
      \ }
let g:which_key_map.c = { 'name' : '+Comment',
      \ 'l' : 'Toggle' ,
      \ }
let g:which_key_map.e = { 'name' : '+Diagnostic',
      \ 'n' : 'Next',
      \ 'p' : 'Prev',
      \ }
let g:which_key_map.f = { 'name' : '+FzfCMD',
      \ 'e' : 'CocExplorer',
      \ 'f' : 'File',
      \ 'h' : 'Home',
      \ 't' : 'Defx',
      \ 'o' : 'DefxRoot',
      \ 'r' : 'Mru',
      \ 'c' : 'Changes',
      \ 'm' : 'Bookmarks',
      \ 'j' : 'Jumps',
      \ 'q' : 'QuickFix',
      \ 'l' : 'LocationList',
      \ }
let g:which_key_map.f.v = { 'name' : '+Vimrc',
      \ 'e' : 'Edit',
      \ 'f' : 'Explorer',
      \ 'r' : 'Reload',
      \ }
let g:which_key_map.w = { 'name' : 'Win',
      \ 'h' : 'Left',
      \ 'j' : 'Down',
      \ 'k' : 'Up',
      \ 'l' : 'Right',
      \ }
let g:which_key_map.p = { 'name' : '+Project',
      \ 'f' : 'ProjectGrep',
      \ 'i' : 'PythonInterpreter',
      \ }
let g:which_key_map.k = { 'name' : '+Custom' ,
      \ 's' : 'RooterSet',
      \ 'r' : 'QuickRun',
      \ 'z' : 'Zoom',
      \ }
let g:which_key_map.t = { 'name' : '+Tab' ,
      \ 'a' : 'Vista',
      \ 'n' : 'NewTab',
      \ 'f' : 'FindTags',
      \ 'c' : 'CloseTab',
      \ 'r' : 'TransReplace',
      \ 'w' : 'TransPopup',
      \ 'e' : 'TransEcho',
      \ }
let g:which_key_map.t.t = { 'name' : '+Terminal' ,
      \ 't' : 'Open',
      \ 'n' : 'New',
      \ }
let g:which_key_map.o = { 'name' : '+Coc' ,
      \ 'a' : 'Diagnostics',
      \ 'A' : 'AllDiagnostics',
      \ 'd' : 'DiagnosticsPopup',
      \ 'c' : 'Commands',
      \ 'e' : 'Extensions',
      \ 'f' : 'FixCurrent',
      \ 'k' : 'SignatureHelp',
      \ 'l' : 'List',
      \ 't' : 'Refactor',
      \ 'o' : 'OutLine',
      \ 'O' : 'Symbols',
      \ 'r' : 'Resume',
      \ 'n' : 'Rename',
      \ 's' : 'Services',
      \ 'y' : 'Yank',
      \ }
let g:which_key_map.g = { 'name' : '+Git',
      \ 'j' : 'PrevChunk',
      \ 'k' : 'NextChunk',
      \ 'p' : 'ChunkInfo',
      \ 'u' : 'ChunkUndo',
      \ 'f' : 'Files',
      \ 's' : 'Status',
      \ 'a' : 'Actions',
      \ 'b' : 'BlamePR',
      \ 'l' : 'Logs',
      \ 'c' : 'Commits',
      \ }

let g:which_key_localmap = { 'name' : '+LocalLeaderKey'  ,
      \ 'e'    : 'Defx',
      \ 'v'    : 'Vista',
      \ 'r'    : 'QuickRun',
      \ 'm'    : 'DeniteMenu',
      \ 'd'    : {
      \'name':'+Todo',
      \ 'a' : 'TodoAdd',
      \},
      \ 'g'  :{
      \'name':'+ GitOperation',
      \ 'a'    : 'Gadd',
      \ 'd'    : 'Gdiff',
      \ 'c'    : 'Gcommit',
      \ 'b'    : 'Gblame',
      \ 'B'    : 'Gbrowse',
      \ 'S'    : 'Gstatus',
      \ 'p'    : 'Gpush',
      \ 'l'    : 'GitLogAll',
      \ 'h'    : 'GitBranch',
      \}
      \ }

let g:which_key_rsbgmap = {
      \ 'name' : '+RightSquarebrackets',
      \ 'a'    : 'AleNextWarp',
      \ 'c'    : 'CocDiagnosticsNext',
      \ 'b'    : 'NextBuffer',
      \ 'g'    : 'CocGitNextChunk',
      \ ']'    : 'Vim-goPrefunction',
      \ }

let g:which_key_lsbgmap = {
      \ 'name' : '+LeftSquarebrackets',
      \ 'a'    : 'AlePreWarp',
      \ 'c'    : 'CocDiagnosticsPre',
      \ 'b'    : 'PreBuffer',
      \ 'g'    : 'CocGitPrevChunk',
      \ '['    : 'Vim-goNextfunction',
      \ }

call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey '<leader>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

