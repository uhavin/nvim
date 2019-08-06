call plug#begin('~/.vim/plugged')

" Fuzzy finding awesomeness
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" git help
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Session management
Plug 'tpope/vim-obsession'

" Prettifying stuff
Plug 'sonph/onehalf', {'rtp': 'vim/'} " Dark and light schemes

"" Other prettifiers
Plug 'Yggdroot/indentLine'  " Indent guides
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Generic code help
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'w0rp/ale'  " linters
Plug 'roxma/nvim-yarp'  " remote plugin manager, dependency of ncm2
Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Misc syntax highlighters and such
Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
Plug 'posva/vim-vue', {'for': 'javascript'}

" NCM completion
Plug 'ncm2/ncm2', {'for': 'python'} " Completion manager
Plug 'ncm2/ncm2-jedi', {'for': 'python'}  " Python plugin for ncm2 completion
Plug 'ncm2/ncm2-bufword', {'for': 'python'}  " Python plugin for ncm2 completion
Plug 'ncm2/ncm2-path', {'for': 'python'}  " Python plugin for ncm2 completion

" Python help
Plug 'davidhalter/jedi-vim', {'for': 'python'}   " jedi for python
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}  "better indenting for python
Plug 'tweekmonster/impsort.vim', {'for': 'python'}
Plug 'alfredodeza/coveragepy.vim', {'for': 'python'}
Plug 'ambv/black', {'for': 'python'}
call plug#end()

let mapleader=';'
let maplocalleader=';'

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" file browsing and searching
nnoremap <Leader>ff :FZF<CR>
nnoremap <Leader>; :FZF<CR>
nnoremap <C-p> :FZF<CR>

nnoremap <Leader>fg :GitFiles<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <C-e> :Buffers<CR>
nnoremap <silent> <Leader>/ :noh<CR>

nnoremap <Leader>> :GitGutterNextHunk<CR>
nnoremap <Leader>< :GitGutterPrevHunk<CR>

nnoremap <Leader>b :Black<CR>

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_winsize= 25

let g:python3_host_prog="/usr/bin/python3.6"

" Open split below and right
set splitbelow
set splitright

"Move between splits with CTRL+Direction (hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set nowrap
set noswapfile
set nobackup


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

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "2"

" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
set shortmess+=c
inoremap <c-c> <ESC>
let ncm2#popup_delay = 5
" Use fuzzy matches
let g:ncm2#matcher = 'substrfuzzy'
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

colo onehalflight
set bg=light
set colorcolumn=89,121
highlight ColorColumn ctermbg=7
set cursorline
set ignorecase
set number
set relativenumber
set smartcase
set tags=.tags
set termguicolors

let g:airline_powerline_fonts=1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename in the tabline
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#branch#format = 1
let g:airline_theme='minimalist'

let g:indentLine_char = '▏'
let g:indentLine_first_char = '▏'
let g:indentLine_color_term = 239
let g:indentLine_show_first_level=1
let g:indentLine_showFirstIndentLevel = 1

let g:tagbar_width=50


set exrc
set secure
