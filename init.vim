call plug#begin(stdpath('data') . '/plugged')
"""" Looks
Plug 'Yggdroot/indentLine'  " Indent guides
Plug 'rakr/vim-one'  " Dark and light themes
Plug 'sonph/onehalf', {'rtp': 'vim/'} " Alternative take on one, better for vim diff
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'frazrepo/vim-rainbow'

" Usability
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo' " Preview registers
Plug 'wincent/ferret'  "Use :Ack for search
Plug 'simeji/winresizer'  " use <Leader>w to resize/move/focus windows
Plug 'simnalamburt/vim-mundo'  " the undo tree

Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'
Plug 'vim-scripts/python_match.vim'

" Programming
"" IntelliSense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-test/vim-test'
Plug 'puremourning/vimspector'

"" Tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'
Plug 'liuchengxu/vista.vim'

" Python
Plug 'fisadev/vim-isort'
Plug 'psf/black', { 'branch': 'stable', 'for': 'python'}
Plug 'alfredodeza/coveragepy.vim', {'for': 'python'}
"" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'junegunn/gv.vim'
call plug#end()


" Use pyenv `nvim` as python for neovim
let g:python3_host_prog='~/.pyenv/versions/nvim/bin/python'

if !empty($PYENV_VIRTUAL_ENV)
  let g:pyenv_name = split($PYENV_VIRTUAL_ENV, "/")[-1:][0]
" Set correct python version for pyright
  call coc#config('python', {
  \   'pythonPath': $PYENV_VIRTUAL_ENV . '/bin/python'
  \ })
endif


"""" Looks
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

set number
set relativenumber

set cursorline
set colorcolumn=89,121

let auycolor="dark"
colo ayu

let g:lightline = {
    \ "colorscheme": "ayu_dark",
    \ "active": {
    \   "left": [ [ "mode", "paste" ],
    \             [ "readonly", "filename", "modified", "git_branch", "pyenv" ] ]
    \ },
    \ "component_function": {
    \   "git_branch": "PrefixedBranch",
    \   "pyenv": "Pyenv"
    \ },
\ }

function! PrefixedBranch()
    let branch_name = FugitiveHead()
    if !empty(branch_name)
        return '' . ' ' . branch_name
    endif
    return ""
endfunction

let g:pyenv = system('pyenv local')
function! Pyenv()
    if !empty($PYENV_VIRTUAL_ENV)
        return ' ' .  g:pyenv_name
    endif
    return ""
endfunction
    

let g:indentLine_char = '▏'
let g:indentLine_first_char = '▏'
let g:indentLine_color_term = 239
let g:indentLine_show_first_level=1
let g:indentLine_showFirstIndentLevel = 1
" indentLine would set conceallevel, hiding the quotes in JSON files and ** in markdown
let g:indentLine_fileTypeExclude = ['json', 'markdown']


"""" Usability
let mapleader=';'
let maplocalleader=';'
let g:peekaboo_window = 'vertical botright 42new'

nnoremap <Leader>/ :noh<CR>

" COC settings by examples from https://github.com/neoclide/coc.nvim
" Use tab/shift-tab to cycle throuhg popup choices.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
" Use ctrl-space to trigger autocompletion
inoremap <silent><expr> <c-space> coc#refresh()
"
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
"
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>t :Vista!!<cr>

nnoremap <Leader>> :GitGutterNextHunk<CR>
nnoremap <Leader>< :GitGutterPrevHunk<CR>

" Open split below and right
set splitbelow
set splitright

" open 2 folds
set foldlevel=2
"Move between splits with CTRL+Direction
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:winresizer_start_key="<Leader>w"


" FZF
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

" file browsing and searching
nnoremap <Leader>; :FZF<CR>
nnoremap <Leader><Space> :Find<Space>
nnoremap <Leader>fg :GitFiles<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>e :Buffers<CR>
" NerdTree
" - close tab when only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" - Close NERDTree when opening that file
" let NERDTreeQuitOnOpen = 1
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
nnoremap <Leader>n :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>. :NERDTreeFind<CR>

" Personally, I find swap files annoying.
set noswapfile
set nobackup

" Keep undo history
set undofile
set undodir=~/.local/share/nvim/undo

" don't wrap lines please
set nowrap

" Autocompletion behavior like bash
set wildmode=longest:full,full

" Search 
set ignorecase " case insensitive...
set smartcase  " ... until typing an uppercase



"""" Programming
"Syntax
"" Tabs, indents and other PEP8 stuff
set tabstop=4
set tabstop=4
set softtabstop=4
set shiftwidth=4 
set expandtab

autocmd BufNewFile,BufRead *.py,*.sh
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

autocmd BufNewFile,BufRead *.js,*.html,*.css,*.yaml,*.yml
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=88 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

set tags=.tags
let g:gutentags_ctags_tagfile='.tags'
let g:vista_sidebar_width=42

let g:vimspector_enable_mappings = 'HUMAN'

" Python
" Linting / fixing
nnoremap <Leader>fb :Black<cr>
" Testing
let test#python#runner = 'pytest'
let test#python#pytest#file_pattern = '\.py'
let test#strategy='neovim'


"""" Misc
" C-A-t to open terminal split below, esc to enter normal mode
function! OpenTerminal()
	split term://zsh
  	resize 12
endfunction
nnoremap <Leader>- :call OpenTerminal()<CR>
" ESC out of the terminal
tnoremap <Esc> <C-\><C-n>
