" General
" Use Vim settings, rather than Vi settings (much better!).
set nocompatible
set encoding=utf-8
filetype indent off
syntax off

" install vim-plug
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"proxychains vim -c "PlugInstall"
" Install plug :PlugInstall
"
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes!!!

" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'

" explorer filesystem
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" tag bar, like taglist, but more better in C/C++
" sudo apt install universal-ctags
Plug 'preservim/tagbar'

" display indenting level
Plug 'nathanaelkane/vim-indent-guides'

" autocompletion
" Install node 16
" curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
" sudo apt-get install -y nodejs
" nodejs >= 12.12
" git clone -b release https://git::github.com/neoclide/coc.nvim.git
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" install coc extension or configure language servers for LSP support.
" :verbose imap
"镜像：npm config set registry https://registry.npmmirror.com
":CocInstall coc-json coc-tsserver
":CocInstall coc-css coc-html
":CocInstall coc-pyright
":CocInstall coc-sh
":CocInstall coc-sql
":CocInstall coc-clangd coc-cmake
":CocInstall coc-markdownlint
"配置
":CocConfig

" glsl
Plug 'tikhomirov/vim-glsl'

" javascript
Plug 'pangloss/vim-javascript'
"
" pip3 install jsbeautifier cssbeautifier
Plug 'maksimr/vim-jsbeautify'

" for markdown
" table
Plug 'dhruvasagar/vim-table-mode'

" need nodejs and yarn
" needto call ":call mkdp#util#install()"
Plug 'iamcco/markdown-preview.nvim'

" css color
Plug 'ap/vim-css-color'

" open browser
Plug 'tyru/open-browser.vim'

" python
" indent
Plug 'hynek/vim-python-pep8-indent'

" syntax check
" python: pip install pylint pyflakes flake8
" c/c++: cppcheck
" Plug 'scrooloose/syntastic'

" color scheme
Plug 'p8952/vim-colors-wombat'
Plug 'tomasr/molokai'

" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git wrapper
Plug 'tpope/vim-fugitive'

call plug#end()

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Vim color
if has("gui_running")
    colorscheme molokai
else
    " To use 256 colors
    set t_Co=256
    colorscheme wombat256mod
endif

filetype indent on
" turn on highlight after colorscheme
syntax on

" vertical line at 81
" ==============================================================================
if v:version > 702
    set colorcolumn=80
    highlight colorcolumn ctermbg=239 guibg=lightgrey
else
    highlight OverLength ctermbg=236 guibg=#2a2a2a
    match OverLength /\%>80v.\+/
endif


" Vim's width and height
if has("gui_running")
    set columns=120
    set lines=40
    "winpos 50 50
endif

" Edit
" =============================================================================
" <TAB>
set tabstop=4         " standard, below method is advised
set softtabstop=4     " replace <tab> with 4 spaces,2 <tab> will be 1 <tab>
set expandtab         " don't use <tab>, only spaces
set shiftwidth=4      " >> indent width
set shiftround


set number            " show line number
" set wrap
set nowrap              " don't automatically wrap on load
" set fo-=t               " don't automatically wrap when typing


set sidescroll=5        " horizonal scroll
set sidescrolloff=5

" set autoindent        " always set autoindenting on
" set smartindent       " smart indent by above line
" set cindent

set backspace=indent,eol,start
set whichwrap=b,s     " permit <BS> to go above, <space> to go below

" backup and swap
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

"set ruler             " show the cursor position at right-bottom corner
set showmatch         " show match (,[,{
"set list              " show tab and eol char

set scrolloff=4       " scroll at 4 line
set vb t_vb=          " disable error bell

set history=1000      " history last command
set undolevels=1000

" status
set laststatus=2      " always show status bar
set showcmd           " display commands in status line
" set cmdheight=2       " status line height, to display <Leader> key
" set mousehide         " Hide the mouse when typing text

" Search
set hlsearch          " search pattern highlight
set incsearch         " do incremental searching
set ignorecase        " search ignore casesensitive
set smartcase
set wrapscan          " search from head when reach end

" File
" ===================================================================
" 设置文件类型
autocmd BufNewFile,BufRead *.txt setlocal filetype=text
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.gltf setlocal filetype=json
autocmd BufNewFile,BufRead *.cmake,CMakeLists.txt setlocal filetype=cmake

" file template
autocmd BufNewFile *.rst  0read ~/.vim/templates/skeleton.rst
autocmd BufNewFile *.py   0read ~/.vim/templates/skeleton.py
autocmd BufNewFile *.html 0read ~/.vim/templates/skeleton.html
autocmd BufNewFile *.sh   0read ~/.vim/templates/skeleton.sh

" goto last position after open file
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
"autocmd QuickFixCmdPost * :copen 5
" Programing language
" python
autocmd FileType python setlocal makeprg=python\ %
autocmd FileType python setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" php
autocmd FileType php setlocal makeprg=php\ %
autocmd FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l
" rest
autocmd FileType text setlocal wrap
autocmd FileType rst setlocal wrap
autocmd FileType markdown setlocal wrap

"autocmd FileType rst setlocal spell spelllang=en_us
autocmd FileType rst setlocal makeprg=rst2html.py\ --cloak-email-addresses\ %\ %.html;firefox\ %.html
"autocmd FileType rst setlocal errorformat=%m\ in\ %f\ on\ line\ %l
" txt

" my customized command
command Todo noautocmd vimgrep /\ TODO:\|\ FIXME:\|\ BUG:\|\ XXX:/j **/*.py **/*.html | cw

" Locale
" input character is original encoding
"let &termencoding=&encoding
"set encoding=utf-8    " use utf-8 internal
set fileencodings=ucs-bom,utf-8,cp936,cp950,latin1
if has("unix")
    set fileformats=unix,dos,mac
else
    set fileformats=dos,unix,mac
endif

" Mouse
" ===================================================================
"set mouse=a
"behave mswin

" Gui
" ===================================================================
set guioptions-=T     " disable toolbar
set guioptions-=m     " disable menubar
set guioptions-=L     " disable left scrollbar
set guioptions-=r     " disable right scrollbar
set guioptions-=b     " disable bottom scrollbar
"set showtabling=0     " disable tab bar

" fonts
" :set guifont=* to open window of selecting font
" Only for gui window. For terminal window need change terminal font
" 1234567890
" abcdefghijklmnopqrstuvwxyg
"set guifont=YaHei\ Consolas\ Hybrid:h12
"set guifont=Consolas:h11
"set guifont=Inconsolata\ Medium\ 12
"set guifont=Liberation\ Mono:h12
"set guifont=DejaVu\ Sans\ Mono:h12

if has("gui_gtk2") || has("gui_gtk3")
    set guifont=Cascadia\ Mono\ PL\ 12
    set guifontwide=Microsoft\ Yahei\ 12,WenQuanYi\ Zen\ Hei\ 12
elseif has("gui_mac")
    set guifont=Cascadia\ Mono\ PL:h12
elseif has("gui_win32")
    set guifont=Cascadia\ Mono\ PL:h12
endif

" clipboard
" need support +clipboard
" share vim clipboard and gui clipboard
" set clipboard=unnamedplus     " for + register, +clipboard
" set clipboard=unnamed         " for * register, +xterm_clipboard
set clipboard=unnamedplus,unnamed

"" map leader
let mapleader = ','

" move code blocks indents
vnoremap < <gv
vnoremap > >gv

" compile
"noremap  <F9> :update<CR>:silent! make<CR>
"noremap! <F9> <ESC>:update<CR>:silent! make<CR>

" debug
map <Leader>b Oimport ipdb; ipdb.set_trace()
" map <Leader>b Oimport web_pdb; web_pdb.set_trace()

" open-browser
map <leader>ob <Plug>(openbrowser-open)

" markdown preview
map <leader>mp <Plug>MarkdownPreview

" default
" input: || to add sepater
" default map
" map <leader>tm :TableModeToggle

" vim-jsbeautify
" unminify...
map <leader>jm :call JsBeautify()<CR>

" vim-airline
" limit line for hang on large file
let g:airline#extensions#whitespace#max_lines = 1000
" other
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#ale#enabled = 1

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" syntastic
" ==============================================================================
" wiki: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
" :SyntasticInfo or :SyntasticCheck
" debug and use :message to show result
" let g:syntastic_debug = 1
"
" Recommended settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" see :h syntastic-loclist-callback
" function! SyntasticCheckHook(errors)
"     if !empty(a:errors)
"         let g:syntastic_loc_list_height = min([len(a:errors), 5])
"     endif
" endfunction

" let g:syntastic_always_populate_loc_list = 1
" open at error and close at non-error
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
"
" python: ['flake8', 'pyflakes', 'pylint', 'python']
" pip install flake8 pyflakes
"let g:syntastic_python_checkers = ['flake8', 'python3']
" http://flake8.pycqa.org/en/latest/index.html
" https://pycodestyle.readthedocs.io/en/latest/index.html
"let g:syntastic_python_flake8_args = "--ignore=E128,E402,E501,F401,C901"
" E402: module level import not at top of file

" c/c++
" let g:syntastic_cpp_check_header = 1
" let g:syntastic_cpp_checkers = ['cppcheck', 'gcc']
" let g:syntastic_cpp_compiler_options = system("pkg-config --cflags QtGui QtWebKit")

" nodejs: https://github.com/nodesource/distributions
" npm install -g eslint
" eslint --init
" let g:syntastic_javascript_checkers = ['eslint']

" Location window
nmap <leader>ln :lnext<CR>
nmap <leader>lp :lprev<CR>
" close quickfix windows
nmap <leader>lc :lclose<CR>
" close preview windows
nmap <leader>pc :pclose<CR>

" 在中文和英文字符之间加一个空格, add space
nmap <leader>sp :s/\([\u4e00-\u9fa5]\)\([0-9a-zA-Z]\)/\1 \2/g<CR>
" #在英文和中文字符之间加一个空格
nmap <leader>sn :s/\([0-9a-zA-Z]\)\([\u4e00-\u9fa5]\)/\1 \2/g<CR>

" markdown-preview
" 0: auto refresh as edit or move the cursor
" 1: refresh when save or leave from insert mode
let g:mkdp_refresh_slow = 1

" tagbar
" ===================================================================
" tagbar do not support displaying related header information on cpp file buffer.
" test with vim
" vim      # Run `:TagbarDebug`, `:e test.c`, `:TagbarToggle`, `:q`
" :messages to show error
" test with cli
" ctags -f - --format=2 --excmd=pattern --extra= --fields=nksaSmt test.c
map <leader>tb  <ESC>:TagbarToggle<CR>
let g:tagbar_width = 30

" indent-guides
" ===================================================================
" default toggle key: <leader>ig :IndentGuidesToggle
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar']
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd ctermbg=236
hi IndentGuidesEven ctermbg=236

" NERDTree
" ===================================================================
" :NERDTree<CR> to show
nmap <Leader>nt <ESC>:NERDTreeToggle<CR>
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
" 窗口位置（'left' or 'right'）
let NERDTreeWinPos='left'
" 窗口宽度
let NERDTreeWinSize=30
" ignore file
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
" Fix NERDTree mouse bug
" set nomousehide
" other
" ===================================================================
