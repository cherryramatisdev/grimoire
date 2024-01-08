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
set foldmethod=indent
set foldenable
set foldlevelstart=10
set foldnestmax=10
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
set laststatus=3
set statusline=%=%{FugitiveStatusline()}\ %f%m\ %y

" -----------------------------------------------------------------------------
"     - I love my blocky cursor! -
" -----------------------------------------------------------------------------
set guicursor=

" -----------------------------------------------------------------------------
"     - Generic key bindings -
" -----------------------------------------------------------------------------
nmap <C-h> :vertical resize -4<CR>
nmap <C-l> :vertical resize +4<CR>
nmap <C-k> :resize +4<CR>
nmap <C-j> :resize -4<CR>
nmap <Leader>} ysiw}

" Terminal flapping
tmap <C-w>k <C-\><C-n><C-w>k 
tmap <C-w>j <C-\><C-n><C-w>j 
tmap <C-w>h <C-\><C-n><C-w>h 
tmap <C-w>l <C-\><C-n><C-w>l 

if has("nvim")
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
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>
nmap <leader>] :cnext<CR>
nmap <leader>[ :cprev<CR>
