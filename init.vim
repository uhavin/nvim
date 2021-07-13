call plug#begin(stdpath('data') . '/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

"""" Looks
"""""" Color schemes aaw yeah
Plug 'sonph/onehalf', {'rtp': 'vim/'} " Alternative take on one
Plug 'ayu-theme/ayu-vim'  " Great dark theme (imho)
Plug 'cormacrelf/vim-colors-github'  " another nice light theme
Plug 'sainnhe/edge'

"""""" Other prettifiers
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'frazrepo/vim-rainbow'
Plug 'Yggdroot/indentLine'  " Indent guides

" Usability

" telescope dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" telescope for finding stuff
Plug 'nvim-telescope/telescope.nvim'

Plug 'wincent/ferret'  "Use :Ack for search
Plug 'junegunn/vim-peekaboo' " Preview registers
Plug 'simeji/winresizer'  " use <Leader>w to resize/move/focus windows
Plug 'simnalamburt/vim-mundo'  " the undo tree

Plug 'preservim/nerdtree' ", { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'bryanmylee/vim-colorscheme-icons'

Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'cohama/lexima.vim'
Plug 'andymass/vim-matchup'
Plug 'vim-scripts/python_match.vim'

" Programming
"" autocompletion
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

Plug 'OmniSharp/omnisharp-vim'

" testing, debugging
Plug 'vim-test/vim-test'
" Plug 'puremourning/vimspector'

"" Tags
Plug 'ludovicchabant/vim-gutentags', {'for': ['py', 'php', 'js']}
Plug 'preservim/tagbar'
Plug 'liuchengxu/vista.vim'

" Python
if has('python3')
    Plug 'fisadev/vim-isort'
    Plug 'psf/black', { 'branch': 'stable', 'for': 'python'}
    Plug 'alfredodeza/coveragepy.vim', {'for': 'python'}
endif

"" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Plug 'shumphrey/fugitive-gitlab.vim'


call plug#end()
" Use pyenv `nvim` as python for neovim

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Use jedi language server
:lua require'lspconfig'.jedi_language_server.setup{}
:lua require'lspconfig'.omnisharp.setup{cmd = { 'omnisharp.exe', '-lsp' }}

set completeopt=menuone,noselect

" Compe config
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.emoji = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.lspconfig = v:true
let g:compe.source.omni = v:false
let g:compe.source.path = v:true
let g:compe.source.spell = v:false
let g:compe.source.ultisnips = v:true
let g:compe.source.vsnip = v:false


inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')


if !empty($PYENV_VIRTUAL_ENV)
  let g:pyenv_name = split($PYENV_VIRTUAL_ENV, "/")[-1:][0]
else
  let g:pyenv_name = ""
endif


"""" Looks
let g:default_plugin_sidebar_size=42

" Lightline
function! PrefixedBranch()
    let branch_name = FugitiveHead()
    if !empty(branch_name)
        return 'git::' . branch_name
    endif
    return ""
endfunction

function! Pyenv()
    if !empty($PYENV_VIRTUAL_ENV)
        return ' ' .  g:pyenv_name
    endif
    return ""
endfunction

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set bg=dark
set cursorline
set colorcolumn=89,121
"
" FOR AYU
let ayucolor="dark"
colo ayu

" FOR GITHUB
" give the colorcolumn a color
" highlight ColorColumn guibg=lightgrey
" colo github
"
" For EDGE
" let g:edge_style = 'default'
" let g:edge_enable_italic = 0
" let g:edge_disable_italic_comment = 1
" colo edge
"
" candidates 
" colo base16-atelier-forest-light


let g:lightline = {
    \ "colorscheme": "ayu_light",
    \ "active": {
    \   "left": [ [ "mode", "paste" ],
    \             [ "readonly", "filename", "modified", "git_branch", "pyenv" ] ]
    \ },
    \ "component_function": {
    \   "git_branch": "PrefixedBranch",
    \   "pyenv": "Pyenv"
    \ },
\ }


set number

let g:indentLine_char = '▏'
let g:indentLine_first_char = '▏'
let g:indentLine_color_term = 239
let g:indentLine_show_first_level=1
let g:indentLine_showFirstIndentLevel = 1

" indentLine would set conceallevel, hiding the quotes in JSON files and ** in markdown
let g:indentLine_fileTypeExclude = ['json', 'markdown']

let g:markdown_fenced_languages = ["python", "javascript"]


"""" Usability
let mapleader=';'
let maplocalleader=';'

let g:peekaboo_window = 'vertical botright 42new'

" move a line down/up
" -o: do not start with comment leader when adding a new line from normal mode using o/O
" -t: do not autowrap using textwidth 
set formatoptions-=ot

nnoremap <silent> <Leader>/ :noh<CR>

nmap <leader>fb :Black

" GoTo code navigation.
" TODO: reuse with mappings to lsp
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

nmap <leader>t :Vista!!<cr>

nmap <leader>> <plug>(signify-next-hunk)
nmap <leader>< <plug>(signify-prev-hunk)

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

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeMapOpenSplit = "x"
let NERDTreeMapPreviewSplit = "gx"
let NERDTreeMapOpenVSplit = "v"
let NERDTreeMapPreviewVSplit = "gv"

let g:NERDTreeWinSize=g:default_plugin_sidebar_size
nnoremap <Leader>n :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>. :NERDTreeFind<CR>

" Git status in nerdtree
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'*',
                \ 'Staged'    :'+',
                \ 'Untracked' :'%',
                \ 'Renamed'   :'~',
                \ 'Unmerged'  :'=',
                \ 'Deleted'   :'-',
                \ 'Dirty'     :'•',
                \ 'Ignored'   :'.',
                \ 'Clean'     :' ',
                \ 'Unknown'   :'?',
                \ }

let NERDTreeIgnore=[".idea", "node_modules", "__pycache__"]

nnoremap <Leader>; :Telescope find_files<CR>
nnoremap <Leader>e :Telescope buffers<CR>

" Personally, I find swap files annoying.
set noswapfile
set nobackup


" Keep undo history
"
set undofile
set undodir=~/.config/nvim/undo

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
    \ set textwidth=9999 |  " Prevent wrapping
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

set tags=.tags
let g:gutentags_ctags_tagfile='.tags'
let g:vista_sidebar_width=g:default_plugin_sidebar_size
" TODO: see if Vista can use LSP-ish exec
" let g:vista_default_executive = 'coc'

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
if (has('win32'))
    " assuming nu shell is installed. Appears to be the quickest with support
    " for Starship and usable enough as vim terminal.
    function! OpenTerminal()
        split | term nu
        resize 12
    endfunction
else
    function! OpenTerminal()
        split | term
        resize 12
    endfunction
endif

nnoremap <Leader>- :call OpenTerminal()<CR>

" ESC to leave terminal 'Insert' mode
tmap <Esc> <C-\><C-n>
