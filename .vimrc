" General
" Use Vim settings, rather than Vi settings (much better!).
set nocompatible
filetype off

" Install vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()
" all bundle
" Install new bundles :BundleInstall
" Update current bundles :BundleUpdate
if exists('g:bundles')
    " manage vundle
    Bundle 'gmarik/vundle'
    " manage other
    Bundle 'Rykka/riv.vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'majutsushi/tagbar'
    Bundle 'vim-scripts/rst-tables--Chao'
    Bundle 'jmcantrell/vim-virtualenv'
    Bundle 'edkolev/tmuxline.vim'
    Bundle 'nathanaelkane/vim-indent-guides'
    " pip install jedi  firstly
    Bundle 'davidhalter/jedi-vim'
    " pip install pylint pyflakes flake8
    Bundle 'scrooloose/syntastic'
    Bundle 'p8952/vim-colors-wombat'
    Bundle 'tomasr/molokai'
    " status bar
    Bundle 'bling/vim-airline'
    Bundle 'tpope/vim-fugitive'
" My github
    Bundle 'liuyug/vim-metaweblog'
endif

filetype plugin indent on

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Vim color
if has("gui_running")
else
    " To use 256 colors
    set t_Co=256
endif
"colorscheme molokai
colorscheme wombat256mod

" vertical line at 81
" ==============================================================================
if v:version >=730
    set colorcolumn=80
    if has("gui_running")
        highlight colorcolumn guibg=lightgrey
    else
        highlight colorcolumn ctermbg=239
    endif
else
    if has("gui_running")
        highlight OverLength guibg=#2a2a2a
    else
        highlight OverLength ctermbg=236
    endif
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
set wrap
" set nowrap              " don't automatically wrap on load
" set fo-=t               " don't automatically wrap when typing


set sidescroll=5        " horizonal scroll
set sidescrolloff=5

"set autoindent        " always set autoindenting on
"set smartindent       " smart indent by above line

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

" show information at status bar
" Use powerline
" set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %c:%l/%L%)

" Search
set hlsearch          " search pattern highlight
set incsearch         " do incremental searching
set ignorecase        " search ignore casesensitive
set smartcase
set wrapscan          " search from head when reach end

" auto-complete
set completeopt=longest,menu
autocmd Filetype python setlocal omnifunc=pythoncomplete#Complete
autocmd Filetype php    setlocal omnifunc=phpcomplete#CompletePHP
autocmd Filetype c      setlocal omnifunc=ccomplete#Complete
autocmd Filetype css    setlocal omnifunc=csscomplete#CompleteCSS
autocmd Filetype html   setlocal omnifunc=htmlcomplete#CompleteTags
autocmd Filetype sql    setlocal omnifunc=sqlcomplete#Complete
autocmd Filetype xml    setlocal omnifunc=xmlcomplete#CompleteTags

" File
" ===================================================================
autocmd BufNewFile,BufRead *.txt setlocal filetype=text
autocmd BufNewFile,BufRead *.cmake,CMakeLists.txt setlocal filetype=cmake

" file template
autocmd BufNewFile *.rst  0read ~/.vim/templates/skeleton.rst
autocmd BufNewFile *.py   0read ~/.vim/templates/skeleton.py
autocmd BufNewFile *.html 0read ~/.vim/templates/skeleton.html

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
autocmd FileType rst setlocal wrap
"autocmd FileType rst setlocal spell spelllang=en_us
autocmd FileType rst setlocal makeprg=rst2html.py\ --cloak-email-addresses\ %\ %.html;firefox\ %.html
"autocmd FileType rst setlocal errorformat=%m\ in\ %f\ on\ line\ %l
" txt
"autocmd FileType txt setlocal wrap

" Locale
" input character is original encoding
"let &termencoding=&encoding
set encoding=utf-8    " use utf-8 internal
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
" 1234567890
" abcdefghijklmnopqrstuvwxyg
"set guifont=YaHei\ Consolas\ Hybrid:h12
"set guifont=Consolas:h11
set guifont=Inconsolata\ Medium\ 12
"set guifont="Liberation Mono":h12
"set guifont="DejaVu Sans Mono":h12
"set guifont="Luxi Mono":h12
"set guifont=Nimbus Mono L":h12

" clipboard
" share vim clipboard and system clipboard
" set clipboard=unnamedplus     " for + register
" set clipboard=unnamed         " for * register

"" map leader
let mapleader = ','

" move code blocks indents
vnoremap < <gv
vnoremap > >gv

" Make shift-insert work like in Xterm, paste
" paste
nmap  <S-Insert>  "+gP
" copy
nmap <C-Insert>   "+y
" cut
nmap <S-Del>      "+x

" compile
noremap  <F9> :update<CR>:silent! make<CR>
noremap! <F9> <ESC>:update<CR>:silent! make<CR>

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tagbar#enabled = 1
" let g:airline_powerline_fonts=1


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


" jedi-vim
" ==============================================================================
" Completion <C-Space>
" Goto assignments <leader>g (typical goto function)
" Goto definitions <leader>d (follow identifier as far as possible, includes imports and statements)
" Show Documentation/Pydoc K (shows a popup with assignments)
" Renaming <leader>r
" Usages <leader>n (shows all the usages of a name)
" Open module, e.g. :Pyimport os (opens the os module)
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_command = ""
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" syntastic
" ==============================================================================
" :SyntasticInfo
let g:syntastic_always_populate_loc_list=1
nmap <leader>ln <ESC>:lnext<CR>
nmap <leader>lp <ESC>:lprev<CR>

" ctrlp - a finder for VIM
" ==============================================================================
" https://github.com/kien/ctrlp.vim
" cd ~/.vim/bundle; git clone https://github.com/kien/ctrlp.vim.git
" <C-p> to activate
" let g:ctrlp_max_height=30
" set wildignore+=*.pyc
" set wildignore+=*.so
" set wildignore+=*_build/*
" set wildignore+=*/coverage/*

" rst_table
" ===================================================================
" wget -O ~/.vim/plugin/rst_table.vim http://www.vim.org/scripts/download_script.php?src_id=12783
" ,,c  ->  Creates a new restructuredText table.
" ,,f  ->  Fix table columns in a table.

" virtualenv
let g:virtualenv_directory = '~/.virtualenvs'
map <leader>vea <ESC>:VirtualEnvActivate<SPACE>
map <leader>ved <ESC>:VirtualEnvDeactivate<CR>
map <leader>vel <ESC>:VirtualEnvList<CR>

" tagbar
map <leader>tb  <ESC>:TagbarToggle<CR>

" indent-guides
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
let NERDTreeWinSize=31
" Fix NERDTree mouse bug
set nomousehide
" other
" ===================================================================


