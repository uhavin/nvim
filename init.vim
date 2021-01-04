"""" Plugins
call plug#begin(stdpath('data') . '/plugged')

" Session management
Plug 'tpope/vim-obsession'


" Color scheme(s)
Plug 'dikiaap/minimalist'
Plug 'ayu-theme/ayu-vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'} " Dark and light schemes
Plug 'jonathanfilip/vim-lucius'
Plug 'nightsense/snow'

" Make it pretty.
Plug 'Yggdroot/indentLine'  " Indent guides
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Preview registers
Plug 'junegunn/vim-peekaboo'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Syntax highlighting
Plug 'preservim/nerdtree'

" show tags in a bar (functions etc) for easy browsing
Plug 'majutsushi/tagbar', { 'for': [ 'python', 'python3' ] }
" automatically create tags
Plug 'ludovicchabant/vim-gutentags', { 'for': [ 'python', 'python3' ] }

" Generic code help


Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Python
Plug 'fisadev/vim-isort'
Plug 'psf/black', { 'branch': 'stable' }


" Git help
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'

call plug#end()


"""" Vim behaviour

" No swap files, no backups. Living on the edge.
set noswapfile
set nobackup
set wildmode=longest:full,full " Autocompletion behavior like bash
set ignorecase 	               " Case insensitivity
set smartcase  	               " Case sensitivity when first uppercase char is typed
set shell=/bin/zsh

" Set semicolon as the leader.
let mapleader=';'
let maplocalleader=';'

" Use tab/shift-tab to cycle throuhg popup choices.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> <Leader>/ :noh<CR> " To clear search highlighting.




"""" Window splitting, movements, navigation.

set splitbelow " horizontal splits open downwards.
set splitright " vertical splits open to the right.

" Move between splits with CTRL+Direction (hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>



"""" Code editing configuration.

set nowrap           " Don't wrap lines for me.
set tabstop=4        " Tab as 4 spaces.
set tags=.tags       " The tags file.

" Should always be the active pyenv.
let g:python3_host_prog="/Users/niels/.pyenv/versions/nvim38/bin/python"

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




""" Colors and other display magic.

set colorcolumn=89,121  " vertical rulers at 89 and 121.
set cursorline 	     	" highlight cursor row
set number     	     	" show the line numbers
set relativenumber   	" relative line numbers.
set termguicolors    	" use gui colors, not term.
set conceallevel=0   	" don't hide the quotes in e.g. json files.

" light grey vertical rulers.
highlight ColorColumn ctermbg=7


" ------
let ayucolor="dark"
" let ayucolor="light"
" let ayucolor="mirage"
colo ayu
" colo minimalist
" colo ayu
" colo onehalfdark
" colo onehalflight
" ------

" Airline config
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename in the tabline
let g:airline#extensions#branch#format = 1
let g:airline_theme='base16'

" Indentation guides
let g:indentLine_char = '▏'
let g:indentLine_first_char = '▏'
let g:indentLine_color_term = 239
let g:indentLine_show_first_level=1
let g:indentLine_showFirstIndentLevel = 1

let g:tagbar_width=50

let $NVIM_TUI_ENABLE_TRUE_COLOR=1



"""" File browsing.
" More useful file browser.
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_winsize= 25

" file browsing and searching
nnoremap <Leader>; :FZF<CR>
nnoremap <Leader><Space> :Find<Space>

nnoremap <Leader>fg :GitFiles<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <C-e> :Buffers<CR>

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

" NERDTree
autocmd StdinReadPre * let s:std_in=1
" Open tree when no files specified.
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open tree on starting by directory.
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim when NERDTree is the only window left.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

nnoremap <Leader>t :NERDTreeToggle<CR>


""" Code helpers.
let g:black_virtualenv="/Users/niels/.venv_black"
nnoremap <Leader>> :GitGutterNextHunk<CR>  " Move to next or
nnoremap <Leader>< :GitGutterPrevHunk<CR>  " previous git hunk.
nnoremap <Leader>b :Black<CR>
nnoremap <Leader>i :Isort<CR>


  if !empty($PYENV_VIRTUAL_ENV)
    call coc#config('python', {
    \   'pythonPath': $PYENV_VIRTUAL_ENV . '/bin/python'
    \ })
  endif



"""" Git / remote repository browsing by Gbrowse
let g:fugitive_gitlab_domains = ['https://gitlab.wearemoose.io']
