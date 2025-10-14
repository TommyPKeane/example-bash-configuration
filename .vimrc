" vim User Configuration File
"
" References:
"   - Sublime Text Syntax Highlighting: https://packagecontrol.io/packages/VimL
"   - https://github.com/amix/vimrc
"   - https://vimhelp.org/
"   - https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/

" vim-plug
"   - https://github.com/junegunn/vim-plug

" Automatically Install if Missing
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug Plugins
"
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
"
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
call plug#begin()

Plug 'prabirshrestha/vim-lsp'  " vim Language Server Protocol (https://github.com/prabirshrestha/vim-lsp)
Plug 'mattn/vim-lsp-settings'

call plug#end()

" Adjust for Autoconfigured Options per plug#end()
filetype indent off   " Disable file-type-specific indentation
syntax on             " Enable syntax highlighting


" lsp
"
" References:
"   - https://www.vimfromscratch.com/articles/vim-and-language-server-protocol
"   - https://frostyx.cz/posts/lsp-for-vim-boomers
let g:lsp_auto_enable = 1
let g:lsp_diagnostics_enabled = 0
let g:lsp_use_native_client = 0
let g:lsp_preview_keep_focus = 0
let g:lsp_preview_float = 1
let g:lsp_preview_autoclose = 0
let g:lsp_completion_documentation_enabled = 1

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)
endfunction


" lsp: pylsp (Python)
"
" References:
"   - ...
if (executable('pylsp'))
    au User lsp_setup call lsp#register_server({
  \ 'name': 'pylsp',
  \ 'cmd': {server_info->['pylsp']},
  \ 'allowlist': ['python']
  \ })
endif


" lsp: ruff
"
" Python Linting and Formatting implemented in Rust
"
" References:
"   - https://docs.astral.sh/ruff/editors/setup/#vim
if executable('ruff')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'ruff',
    \ 'cmd': {server_info->['ruff', 'server']},
    \ 'allowlist': ['python'],
    \ 'workspace_config': {},
    \ })
endif


" lsp Install Language Servers
augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" General Configuration Options
"   - https://vimhelp.org/
"   - https://github.com/amix/vimrc


" ruler
"
" References:
"   - https://vimhelp.org/options.txt.html#%27ruler%27
set ruler


" wildmenu
"
" When 'wildmenu' is on, command-line completion operates in an enhanced mode.  On
" pressing 'wildchar' (usually <Tab>) to invoke completion, the possible matches are
" shown.
"
" References:
"   - https://vimhelp.org/options.txt.html#%27wildmenu%27
"   - https://vimhelp.org/options.txt.html#%27wildoptions%27
set wildmenu
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
set wildmode=longest:full
set wildoptions=pum
