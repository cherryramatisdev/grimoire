" -----------------------------------------------------------------------------
"   - General settings -
" -----------------------------------------------------------------------------
compiler tsc
set makeprg=bun\ tsc\ -noEmit

" -----------------------------------------------------------------------------
"   - Key mappings -
" -----------------------------------------------------------------------------
nmap <C-b> :call CompileSomeTS()<cr>
