call plug#begin('~/.vim/plugged')

" File navigation awesomeness
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" git help
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Session management
Plug 'tpope/vim-obsession'

" Prettifying stuff
Plug 'ayu-theme/ayu-vim'
Plug 'rakr/vim-one'
Plug 'sonph/onehalf', {'rtp': 'vim/'} " Dark and light schemes


"" Other prettifiers
Plug 'Yggdroot/indentLine'  " Indent guides
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Generic code help
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'dense-analysis/ale'  " linters
Plug 'roxma/nvim-yarp'  " remote plugin manager, dependency of ncm2
Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Misc syntax highlighters and such
Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
" JavaScript help
" Plug 'othree/yajs.vim', {'for': 'javascript'}
" Plug 'posva/vim-vue', {'for': 'javascript'}

" NCM completion
Plug 'ncm2/ncm2', {'for': 'python'} " Completion manager
Plug 'ncm2/ncm2-jedi', {'for': 'python'}  " Python plugin for ncm2 completion
Plug 'ncm2/ncm2-bufword', {'for': 'python'}  " Python plugin for ncm2 completion
Plug 'ncm2/ncm2-path', {'for': 'python'}  " Python plugin for ncm2 completion

" Python help
Plug 'alfredodeza/coveragepy.vim', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}   " jedi for python
Plug 'psf/black', {'for': 'python'}
Plug 'tweekmonster/impsort.vim', {'for': 'python'}
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}  " better indenting for python
Plug 'alfredodeza/coveragepy.vim', {'for': 'python'}  " .coverge reporting

call plug#end()

" Define :Find commmand
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

let mapleader=';'
let maplocalleader=';'

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" file browsing and searching
nnoremap <Leader>; :FZF<CR>
nnoremap <Leader><Space> :Find<Space>

nnoremap <Leader>fg :GitFiles<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <C-e> :Buffers<CR>
nnoremap <silent> <Leader>/ :noh<CR>

nnoremap <Leader>> :GitGutterNextHunk<CR>
nnoremap <Leader>< :GitGutterPrevHunk<CR>

nnoremap <Leader>b :Black<CR>
nnoremap <Leader>i :ImpSort<CR>

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_winsize= 25

let g:python3_host_prog="/usr/bin/python3"

" NerdTree
" - open NERDTree when typing vim (w/o any file given)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" - close tab when only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" - Close NERDTree when opening that file
let NERDTreeQuitOnOpen = 1
" - Close buffer when deleting a file
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeMapOpenSplit = "x"
let NERDTreeMapPreviewSplit = "gx"
" let NERDTreeMapCloseDir = "<"
" let NERDTREEMapCloseChildren = "<<"
let NERDTreeMapOpenVSplit = "v"
let NERDTreeMapPreviewVSplit = "gv"
nnoremap <Leader>t :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>. :NERDTreeFind<CR>

" NERDTree git plugin
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "*",
"     \ "Staged"    : "+",
"     \ "Untracked" : "%",
"     \ "Renamed"   : "~",
"     \ "Unmerged"  : "=",
"     \ "Deleted"   : "-",
"     \ "Dirty"     : "!",
"     \ "Clean"     : "v",
"     \ 'Ignored'   : 'i',
"     \ "Unknown"   : "?"
"     \ }

" Open split below and right
set splitbelow
set splitright

"Move between splits with CTRL+Direction (hjkl)
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
let ncm2#popup_delay = 2
" Use fuzzy matches
let g:ncm2#matcher = 'substrfuzzy'
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set colorcolumn=89,121
highlight ColorColumn ctermbg=7
set cursorline
set ignorecase
set number
set relativenumber
set smartcase
set tags=.tags
set termguicolors

" let ayucolor="light"
colo onehalflight
" don't hide the quotes in e.g. json files.
set conceallevel=0

let g:airline_powerline_fonts=1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename in the tabline
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#branch#format = 1
let g:airline_theme='base16'

let g:indentLine_char = '▏'
let g:indentLine_first_char = '▏'
let g:indentLine_color_term = 239
let g:indentLine_show_first_level=1
let g:indentLine_showFirstIndentLevel = 1

let g:tagbar_width=50


set exrc
set secure
