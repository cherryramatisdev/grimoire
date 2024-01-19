compiler cargo
" -----------------------------------------------------------------------------
"     - General settings -
" -----------------------------------------------------------------------------
set textwidth=99
set nospell

" -----------------------------------------------------------------------------
"     - Key mappings -
" -----------------------------------------------------------------------------
nmap <C-b> :call CompileSomeRust()<CR>
nmap <Leader>x :!cargo run<CR>

nmap <leader>d :DebugMain<CR>
nmap <leader>b :DebugAndBreak<CR>
nmap ; :Over<CR>
nmap <leader>; :Step<CR>

nmap <leader>rt :RustTest<CR>
nmap <leader>tt :DebugTest<CR>

" -----------------------------------------------------------------------------
"     - Abbreviations -
" -----------------------------------------------------------------------------
ia cmt cmt<tab><Left>
ia dd #[derive(Debug)]

let g:rustfmt_command = "rustfmt +nightly"
