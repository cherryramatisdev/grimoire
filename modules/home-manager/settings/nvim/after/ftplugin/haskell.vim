" -----------------------------------------------------------------------------
"     - General settings -
" -----------------------------------------------------------------------------
compiler ghc
set makeprg=cabal\ build\ -fno-code

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" -----------------------------------------------------------------------------
"     - Key mappings -
" -----------------------------------------------------------------------------
nmap <C-b> :call CompileSomeHaskell()<cr>
