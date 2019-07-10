"*****************************************************************************
"" init
"*****************************************************************************

if !exists('g:plug_path')
  let g:plug_path = expand('$HOME/.cache/vim/plugs')
endif

let s:vimplug_exists = expand('$PLUG_DIR/plug.vim')

let g:vim_bootstrap_langs = "c,go,html,javascript,lua,python,typescript"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(s:vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . s:vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall --sync
  source ~/.vimrc
endif

let g:vimrc_author = 'sohunjug'
let g:vimrc_email = 'sohunjug@gmail.com'
let g:vimrc_homepage = 'https://sohunjug.com/'

nmap <Leader>ai :AuthorInfoDetect<CR>

source s:vimplug_exists

let s:plugins = fnamemodify(expand('<sfile>'), ':h').'/plugins.vim'
if filereadable(expand(s:plugins))
  execute 'source' s:plugins
endif

let s:setting = fnamemodify(expand('<sfile>'), ':h').'/setting.vim'
if filereadable(expand(s:setting))
  execute 'source' s:setting
endif

