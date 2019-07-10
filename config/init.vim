"*****************************************************************************
"" init
"*****************************************************************************

if !exists('g:plug_path')
  let g:plug_path = expand('$HOME/.cache/vim/plugs')
endif

let s:vimplug_path = expand(g:plug_path . '/plug/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,go,html,javascript,lua,python,typescript"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(s:vimplug_path)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . s:vimplug_path . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall --sync
endif
let s:vimplug_path = expand(g:plug_path . '/plug/')
execute 'set runtimepath^=' . substitute(fnamemodify(s:vimplug_path, ':p'), '/$', '', '')

let g:vimrc_author = 'sohunjug'
let g:vimrc_email = 'sohunjug@gmail.com'
let g:vimrc_homepage = 'https://sohunjug.com/'

nmap <Leader>ai :AuthorInfoDetect<CR>

let s:plugins = fnamemodify(expand('<sfile>'), ':h').'/svim.plugins'
if filereadable(expand(s:plugins))
  execute 'source ' . s:plugins
endif

let s:setting = fnamemodify(expand('<sfile>'), ':h').'/svim.setting'
if filereadable(expand(s:setting))
  execute 'source ' . s:setting
endif

