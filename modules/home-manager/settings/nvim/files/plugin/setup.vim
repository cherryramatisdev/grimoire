" -----------------------------------------------------------------------------
"     - Colours -
" -----------------------------------------------------------------------------
colorscheme togglebit

" -----------------------------------------------------------------------------
"     - Leader -
" -----------------------------------------------------------------------------
let g:mapleader="\\"

" -----------------------------------------------------------------------------
"     - Default settings -
" -----------------------------------------------------------------------------
filetype plugin indent on
syntax on

set nopreviewwindow
set fillchars+=vert:│
set tabstop=4
set expandtab
set shiftwidth=4
set whichwrap=b,s,<,>,h,l,[,]
set incsearch
set ignorecase
set smartcase
set smartindent
set wildmenu
set wildmode=full
" set foldmethod=indent
" set foldenable
" set foldlevelstart=10
" set foldnestmax=10
set ruler
set splitright
set splitbelow
set backspace=indent,eol,start
set nowrap
set nohlsearch
set ttimeoutlen=10
set mouse=
set noswapfile
set colorcolumn=80
set nosmd
set hidden
set completeopt=menuone,noinsert
set autoread
set autowrite

" -----------------------------------------------------------------------------
"     - I love my blocky cursor! -
" -----------------------------------------------------------------------------
set guicursor=

" -----------------------------------------------------------------------------
"     - Generic key bindings -
" -----------------------------------------------------------------------------
nmap <C-h> <cmd>vertical resize -4<CR>
nmap <C-l> <cmd>vertical resize +4<CR>
nmap <C-k> <cmd>resize +4<CR>
nmap <C-j> <cmd>resize -4<CR>
nmap <Leader>} ysiw}

if has("nvim")
    au TermOpen * startinsert
    au TermOpen * exec "normal G"
endif

" -----------------------------------------------------------------------------
"     - Grep -
" -----------------------------------------------------------------------------
set grepprg=rg\ --vimgrep


" -----------------------------------------------------------------------------
"     - Debugging -
" -----------------------------------------------------------------------------
packadd termdebug
let g:termdebug_wide = 1
let g:TermDebugging = 0
au User TermdebugStartPre let g:TermDebugging = 1
au User TermdebugStopPost let g:TermDebugging = 0

" -----------------------------------------------------------------------------
"     - Date functions -
" -----------------------------------------------------------------------------
" Insert date stamp above current line.
" This is useful when organising tasks in README.md
function! InsertDateStamp()
    let l:date = system('date +\%F')
    let l:oneline_date = split(date, "\n")[0]
    execute "normal! a" . oneline_date . "\<Esc>"
endfunction

:command! DS call InsertDateStamp()


" -----------------------------------------------------------------------------
"     - Human error correction -
" -----------------------------------------------------------------------------
:command! W w
:command! Q q
:command! Wq wq

" -----------------------------------------------------------------------------
"     - Quickfix list -
" -----------------------------------------------------------------------------
au FileType qf wincmd J
nmap ]q <cmd>cnext<CR>
nmap [q <cmd>cprev<CR>

" -----------------------------------------------------------------------------
"   - general mappings -
" -----------------------------------------------------------------------------
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" -----------------------------------------------------------------------------
"   - Yank mappings -
" -----------------------------------------------------------------------------
nnoremap <space>y "+y
vnoremap <space>y "+y
nnoremap <space>Y "+y$

" -----------------------------------------------------------------------------
"   - Tab mappings -
" -----------------------------------------------------------------------------
nnoremap ;t <cmd>tabnew<cr>
nnoremap <tab> gt
nnoremap <s-tab> gT
