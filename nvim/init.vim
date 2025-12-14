" Note:
" disable windows terminal shortcut: ctrl+c, ctrl+v
" windows - C:\Users\USERNAME\AppData\Local\nvim\init.vim
" windows - %localappdata%\nvim\init.vim
"
" Git
" It access remote server through SSH
" disable external SSH and use internal windows ssh
" set GIT_SSH=
" set SVN_SSH=
" ssh config: ~/.ssh
"
" :checkhealth
"
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if has("win32")
    " for Window
    silent! call plug#begin('~/AppData/Local/nvim/plugged')
else
    " for Linux
    call plug#begin('~/.config/nvim/plugged')
endif

" Example plugin
Plug 'preservim/nerdtree'        " File explorer

" sudo apt install universal-ctags
Plug 'preservim/tagbar'
" mark
" Plug '2KAbhishek/markit.nvim'
Plug 'chentoast/marks.nvim'
Plug 'tpope/vim-fugitive'        " Git integration
Plug 'vim-airline/vim-airline'   " Status bar
Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
" Coc 需要 nodejs, ubuntu在 wsl1 下的nodejs 有问题，需要手动安装
" # https://deb.nodesource.com/
" curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
" sudo apt-get install -y nodejs
" git clone https://github.com/neoclide/coc.nvim --branch release
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Intellisense engine
" install coc extensions or configure language servers for LSP support.
" ~/.config/coc/extensions/node_modules
" :CocConfig
" :CocInstall coc-pyright coc-json coc-html coc-css coc-sh coc-sql
" sudo apt install clangd
" coc-clangd
" coc-cmake
"
" Telescope
" winget install BurntSushi.ripgrep.MSVC
" sudo apt install ripgrep
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.2.0' }

Plug 'numToStr/FTerm.nvim'

Plug 'sakhnik/nvim-gdb'
" dap
" Plug 'mfussenegger/nvim-dap'
" Plug 'nvim-neotest/nvim-nio'
" Plug 'rcarriga/nvim-dap-ui'

Plug 'p8952/vim-colors-wombat'

" python indent
Plug 'hynek/vim-python-pep8-indent'
" display indenting level
Plug 'nathanaelkane/vim-indent-guides'

Plug 'ap/vim-css-color'
" Plug 'tikhomirov/vim-glsl'
Plug 'pangloss/vim-javascript'
Plug 'Glench/Vim-Jinja2-Syntax'
call plug#end()

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Set the color scheme
" colorscheme desert
colorscheme wombat256mod

filetype indent on
" Enable syntax highlighting
syntax on

set colorcolumn=80
highlight colorcolumn ctermbg=239 guibg=grey

" Enable line numbers
set number

" Set the tab width to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set shiftround
" 缩进
" set cindent cino=j1
set cindent cino=j1,(0,ws,Ws

" set nowrap

" Use system clipboard
set clipboard=unnamedplus

" Enable mouse support
set mouse=a

" Set relative line numbers
" set relativenumber

" Enable incremental search
set incsearch

" Highlight search results
set hlsearch
set ignorecase        " search ignore casesensitive
set smartcase
set wrapscan          " search from head when reach end

" Set the default encoding to UTF-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,cp950,latin1

" Show the matching part of the pair for [] {} and ()
set showmatch

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect

" Avoid showing extra messages when using completion
set shortmess+=c


" autocmd FileType text setlocal wrap
" autocmd FileType rst setlocal wrap
" autocmd FileType markdown setlocal wrap
autocmd FileType rst setlocal makeprg=rst2html\ --cloak-email-addresses\ %\ %.html
autocmd FileType cpp setlocal makeprg=cd build & mingw32-make

if has("win32")
    silent! call plug#begin('~/AppData/Local/nvim/plugged')
    autocmd BufNewFile *.py   0read ~/AppData/Local/nvim/templates/skeleton.py
    autocmd BufNewFile *.html 0read ~/AppData/Local/nvim/templates/skeleton.html
    autocmd BufNewFile *.sh   0read ~/AppData/Local/nvim/templates/skeleton.sh
else
    autocmd BufNewFile *.py   0read ~/.vim/templates/skeleton.py
    autocmd BufNewFile *.html 0read ~/.vim/templates/skeleton.html
    autocmd BufNewFile *.sh   0read ~/.vim/templates/skeleton.sh
endif

command Todo noautocmd vimgrep /\ TODO:\|\ FIXME:\|\ BUG:\|\ XXX:/j **/*.py **/*.html | cw

" Map leader key
let mapleader=","

" move block
vnoremap < <gv
vnoremap > >gv

" 在中文和英文字符之间加一个空格, add space
" 在英文和中文字符之间加一个空格
nmap <leader>sp :s/\([\u4e00-\u9fa5]\)\([0-9a-zA-Z]\)/\1 \2/g<CR>:s/\([0-9a-zA-Z]\)\([\u4e00-\u9fa5]\)/\1 \2/g<CR>

" Close buffer
noremap <Leader>bd :bnext<CR>:bdelete#<CR>:redraw<CR>
noremap <Leader>bp :bprevious<CR>
noremap <Leader>bn :bnext<CR>

" NERDTree configuration
" nmap <C-n> :NERDTreeToggle<CR>
nmap <Leader>nt :NERDTreeToggle<CR>
let NERDTreeWinSize=31
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDChristmasTree=1
" focus on center
let NERDTreeAutoCenter=1
" mouse mode
let NERDTreeMouseMode=2
" 是否默认显示书签列表
let NERDTreeShowBookmarks=1
" 是否默认显示文件
let NERDTreeShowFiles=1
" 是否默认显示隐藏文件
let NERDTreeShowHidden=1
" 是否默认显示行号
let NERDTreeShowLineNumbers=0
" 窗口位置（'left', 'right', top, bottom）
let NERDTreeWinPos='left'

nmap <leader>tt  <ESC>:TagbarToggle<CR>
let g:tagbar_position = 'right'
let g:tagbar_width = 30

" debug
let g:nvimgdb_disable_start_keymaps = 0
"    vim.api.nvim_set_keymap('n', '<leader>dd', ':GdbStart gdb -q ', { noremap = true })
"    vim.api.nvim_set_keymap('n', '<leader>dl', ':GdbStartLLDB lldb ', { noremap = true })
"    vim.api.nvim_set_keymap('n', '<leader>dp', ':GdbStartPDB python -m pdb main.py', { noremap = true })
"    vim.api.nvim_set_keymap('n', '<leader>db', ':GdbStartBashDB bashdb main.sh', { noremap = true })
"    vim.api.nvim_set_keymap('n', '<leader>dr', ':GdbStartRR', { noremap = true })
" When debugging session has started, the following mappings are defined:
" <f4>                   Until                          (`:GdbUntil`)
" <f5>                   Continue                       (`:GdbContinue`)
" <f10>                  Next                           (`:GdbNext`)
" <f11>                  Step                           (`:GdbStep`)
" <f12>                  Finish                         (`:GdbFinish`)
" <f8>                   Toggle breakpoint              (`:GdbBreakpointToggle`)
" <c-p>                  Frame Up                       (`:GdbFrameUp`)
" <c-n>                  Frame Down                     (`:GdbFrameDown`)
" <f9>                   NORMAL: Evaluate word under cursor (`:GdbEvalWord`)
"                        VISUAL: Evaluate the range         (`:GdbEvalRange`)

map <Leader>dd :GdbStart gdb -q

map <Leader>dp :GdbStartPDB python -m pdb
map <Leader>db Oimport ipdb; ipdb.set_trace()

" Enable airline
let g:airline#extensions#tabline#enabled = 1
" limit line for hang on large file
let g:airline#extensions#whitespace#max_lines = 1000
let g:airline_powerline_fonts = 1

" vim-indent-guids
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar']
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd ctermbg=236
hi IndentGuidesEven ctermbg=236

" Some lsp servers have issues with backup files, see #649
set nobackup
set nowritebackup

" CoC (Conqueror of Completion) configuration
" Use tab for trigger completion with characters ahead and navigate
" Note: Use command ':CocConfig' to configure coc.nvim
" inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Show documentation
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" load lua config
lua require('init')
" lua keymap
nmap <leader>sh <ESC>:lua require("FTerm").toggle()<CR>
