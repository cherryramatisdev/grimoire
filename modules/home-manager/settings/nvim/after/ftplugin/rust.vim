" -----------------------------------------------------------------------------
"     - General settings -
" -----------------------------------------------------------------------------
set textwidth=99
set nospell

" -----------------------------------------------------------------------------
"     - Key mappings -
" -----------------------------------------------------------------------------
nmap <C-b> :Compile<CR>
nmap <Leader>x :Cargo run<CR>
nmap <silent> <Leader>f :RustFmt<CR>
nmap gv <Plug>(rust-def-vertical)

nmap <leader>d :DebugMain<CR>
nmap <leader>b :DebugAndBreak<CR>
nmap ; :Over<CR>
nmap <leader>; :Step<CR>

nmap <leader>rt :RustTest<CR>
nmap <leader>tt :DebugTest<CR>

" -----------------------------------------------------------------------------
"     - Abbreviations -
" -----------------------------------------------------------------------------
ia cmt cmt<Leader>t<Left>
ia dd #[derive(Debug)]

let g:rustfmt_command = "rustfmt +nightly"
