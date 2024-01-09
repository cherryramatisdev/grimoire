" -----------------------------------------------------------------------------
"     - General settings -
" -----------------------------------------------------------------------------
set makeprg=ghc\ -dynamic\ %

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" -----------------------------------------------------------------------------
"     - Key mappings -
" -----------------------------------------------------------------------------
nmap <C-b> :!clear;ghc -fno-code -dynamic % <cr>
