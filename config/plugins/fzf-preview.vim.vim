let g:fzf_preview_floating_window_rate = 0.6
let g:fzf_preview_default_fzf_options = { '--reverse': v:true, '--preview-window': 'wrap' }
" jump to the buffers by default, when possible
let g:fzf_preview_buffers_jump = 1
let g:fzf_preview_fzf_preview_window_option = 'right:40%'
let g:fzf_preview_use_dev_icons = 1
" devicons character width
let g:fzf_preview_dev_icon_prefix_string_length = 3
let g:fzf_preview_grep_cmd = 'rg --column --line-number --no-heading --color=always --smart-case'
let g:fzf_preview_cache_directory = expand('~/.cache/vim/fzf_preview')
" let g:fzf_preview_preview_key_bindings = 'ctrl-f:preview-page-down,ctrl-b:preview-page-up,?:toggle-preview,ctrl-d:'

au FileType fzf tnoremap <buffer> <C-j> <Down>
au FileType fzf tnoremap <buffer> <C-k> <Up>
au FileType fzf tunmap <buffer> <Esc>

function! s:RipgrepFzfWithWiki(query, fullscreen)
    " 这个是在安装了vimwiki插件后使用的功能，需要配置一下g:vimwiki_path路径
    if g:HasPlug('vimwiki') && &ft ==? 'vimwiki' && match(expand('%:p'), expand(g:vimwiki_path)) > -1
        let wiki_path = g:vimwiki_path
    else
        let wiki_path = ""
    endif
    execute 'FzfPreviewProjectGrep .' . ' ' . wiki_path
endfunction
command! -nargs=* -bang GrepWithWiki call s:RipgrepFzfWithWiki(<q-args>, <bang>0)

function! s:FilesWithWiki(query, fullscreen)
    let l:q=a:query
    if empty(l:q) && g:HasPlug('vimwiki') && &ft ==? 'vimwiki' && match(expand('%:p'), expand(g:vimwiki_path)) > -1
        let l:q=g:vimwiki_path
    endif
    exec 'FzfPreviewDirectoryFiles' . ' ' . l:q
endfunction
command! -bang -nargs=? -complete=dir FWW call s:FilesWithWiki(<q-args>, <bang>0)

nnoremap <leader>ff :<c-u>FWW<CR>
nnoremap <leader>fh :<c-u>FWW $HOME<CR>
nnoremap <leader>bb :<c-u>FzfPreviewAllBuffers<CR>
if g:HasPlug('vista.vim')
    nnoremap <leader>tf :<c-u>FzfPreviewVistaBufferCtags<CR>
    nnoremap <leader>tF :<c-u>FzfPreviewVistaCtags<CR>
else
    nnoremap <leader>tf :<c-u>FzfPreviewVistaBufferTags<CR>
    nnoremap <leader>tF :<c-u>FzfPreviewVistaCtags<CR>
endif
" 使用rg搜索工作目录或者笔记目录
nnoremap <leader>pf :GrepWithWiki<CR>
" 模糊搜索所有buffer
nnoremap <leader>? :<c-u>FzfPreviewBufferLines<CR>
if executable('bat')
    nnoremap <silent> <leader>* :<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
endif
nnoremap <leader>fr :<c-u>FzfPreviewMruFiles<CR>
nnoremap <leader>fc :<c-u>FzfPreviewChanges<CR>
if g:HasPlug('vim-bookmarks')
    nnoremap <leader>fm :<c-u>FzfPreviewBookmarks<CR>
else
    nnoremap <leader>fm :<c-u>FzfPreviewMarks<CR>
endif
if g:HasPlug('yankround.vim')
    nnoremap <leader>fy :<c-u>FzfPreviewYankround<CR>
endif
nnoremap <leader>fj :<c-u>FzfPreviewJumps<CR>
nnoremap <leader>fq :<c-u>FzfPreviewQuickFix<CR>
nnoremap <leader>fl :<c-u>FzfPreviewLocationList<CR>

" git相关
nnoremap <leader>gf :<c-u>FzfPreviewGitFiles<CR>
nnoremap <leader>gs :<c-u>FzfPreviewGitStatus<CR>
nnoremap <leader>ga :<c-u>FzfPreviewGitActions<CR>
nnoremap <leader>gb :<c-u>FzfPreviewBlamePR<CR>
nnoremap <leader>gl :<c-u>FzfPreviewGitLogs<CR>
