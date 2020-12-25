call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Prettifying stuff
Plug 'ParamagicDev/vim-medic_chalk'  " nice for dark
Plug 'rakr/vim-one'  " Dark and light themes
Plug 'sonph/onehalf', {'rtp': 'vim/'} " Alternative take on one, better for vim diff
call plug#end()

let airline_theme='one'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" colors
set background=light
colo one

" Open split below and right
set splitbelow
set splitright

"Move between splits with CTRL+Direction
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Personally, I find swap files annoying.
set nowrap
set noswapfile
set nobackup

" Autocompletion behavior like bash
set wildmode=longest:full,full

set tabstop=4

" Tabs, indents and other PEP8 stuff
autocmd BufNewFile,BufRead *.py,*.sh
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

autocmd BufNewFile,BufRead *.js,*.html,*.css,*.yaml,*.yml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=88 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

set colorcolumn=89,121
highlight ColorColumn ctermbg=7
set cursorline
set ignorecase
set number
set relativenumber
set smartcase
set tags=.tags
set termguicolors
