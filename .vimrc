" vim User Configuration File
"
" References:
"   - Sublime Text Syntax Highlighting: https://packagecontrol.io/packages/VimL
"   - https://github.com/amix/vimrc
"   - https://vimhelp.org/
"   - https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/

" vim <leader> and <localleader>
let mapleader = ","
let maplocalleader = "\\"

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

Plug 'yegappan/lsp'  " vim Language Server Protocol (https://github.com/prabirshrestha/vim-lsp)

call plug#end()

" Adjust for Autoconfigured Options per plug#end()
filetype indent off   " Disable file-type-specific indentation
syntax on             " Enable syntax highlighting


" lsp
"
" References:
"   - https://www.vimfromscratch.com/articles/vim-and-language-server-protocol
"   - https://frostyx.cz/posts/lsp-for-vim-boomers
let lspOpts = #{
  \ aleSupport: v:false,
  \ autoComplete: v:true,
  \ autoHighlight: v:false,
  \ autoHighlightDiags: v:true,
  \ autoPopulateDiags: v:false,
  \ completionMatcher: 'case',
  \ completionMatcherValue: 1,
  \ diagSignErrorText: 'E>',
  \ diagSignHintText: 'H>',
  \ diagSignInfoText: 'I>',
  \ diagSignWarningText: 'W>',
  \ echoSignature: v:false,
  \ hideDisabledCodeActions: v:false,
  \ highlightDiagInline: v:true,
  \ hoverInPreview: v:true,
  \ ignoreMissingServer: v:false,
  \ keepFocusInDiags: v:true,
  \ keepFocusInReferences: v:true,
  \ completionTextEdit: v:true,
  \ diagVirtualTextAlign: 'above',
  \ diagVirtualTextWrap: 'default',
  \ noNewlineInCompletion: v:false,
  \ omniComplete: v:null,
  \ omniCompleteAllowBare: v:false,
  \ outlineOnRight: v:false,
  \ outlineWinSize: 20,
  \ popupBorder: v:true,
  \ popupBorderHighlight: 'Title',
  \ popupBorderHighlightPeek: 'Special',
  \ popupBorderSignatureHelp: v:false,
  \ popupHighlightSignatureHelp: 'Pmenu',
  \ popupHighlight: 'Normal',
  \ semanticHighlight: v:true,
  \ showDiagInBalloon: v:true,
  \ showDiagInPopup: v:true,
  \ showDiagOnStatusLine: v:false,
  \ showDiagWithSign: v:true,
  \ showDiagWithVirtualText: v:false,
  \ showInlayHints: v:false,
  \ showSignature: v:true,
  \ snippetSupport: v:false,
  \ ultisnipsSupport: v:false,
  \ useBufferCompletion: v:false,
  \ usePopupInCodeAction: v:false,
  \ useQuickfixForLocations: v:false,
  \ vsnipSupport: v:false,
  \ bufferCompletionTimeout: 100,
  \ customCompletionKinds: v:false,
  \ completionKinds: {},
  \ filterCompletionDuplicates: v:false,
  \ condensedCompletionMenu: v:false,
\}
autocmd User LspSetup call LspOptionsSet(lspOpts)


" lsp: pylsp (Python)
"
" References:
"   - ...
if (executable('pylsp'))
  let lspServers = [#{
    \   name: 'pylsp',
    \   cmd: {server_info->['pylsp']},
    \   allowlist: ['python']
    \ }]
  autocmd User LspSetup call LspAddServer(lspServers)
endif


" lsp: ruff
"
" Python Linting and Formatting implemented in Rust
"
" References:
"   - https://docs.astral.sh/ruff/editors/setup/#vim
if executable('ruff')
  let lspServers = [#{
    \   name: 'ruff',
    \   cmd: {server_info->['ruff', 'server']},
    \   allowlist: ['python'],
    \   workspace_config: {},
    \ }]
  autocmd User LspSetup call LspAddServer(lspServers)
endif


" lsp: C / C++ (clang)
"
" C/C++ Linting and Formatting implemented in clang
"
" References:
"   - ...
if executable('clangd')
  let lspServers = [#{
    \   name: 'clang',
    \   filetype: ['c', 'cpp'],
    \   path: '/usr/bin/clangd',
    \   args: ['--background-index']
    \ }]
  autocmd User LspSetup call LspAddServer(lspServers)
endif


" lsp Remappings
set keywordprg=:LspHover


" General Configuration Options
"   - https://vimhelp.org/
"   - https://github.com/amix/vimrc


" filetype
:filetype plugin on
:filetype indent on


" number
set number
set numberwidth=6


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
