" Config file
" vim run direcotry:  
" $VIMRUNTIME
" vim config file
" For Window $HOME/_vimrc
"            $VIM/_vimrc
" For Linux  ~/.vimrc
" vim config dir :
" ~/.vim
"

" General
" Use Vim settings, rather than Vi settings (much better!).
set nocompatible

" Vim color
" term color
" curl -Sso ~/.vim/colors/wombat256mod.vim \
"    https://raw.github.com/mbrochh/mbrochh-dotfiles/master/.vim/colors/wombat256mod.vim

if has("gui_running")
    colorscheme molokai
    "colorscheme desert
else
    " To use 256 colors
    set t_Co=256
    colorscheme wombat256mod
endif

" vertical line at 81 
" ==============================================================================
if v:version >=730
    set colorcolumn=80
    if has("gui_running")
        highlight colorcolumn guibg=lightgrey
    else
        highlight colorcolumn ctermbg=236
    endif
else
    if has("gui_running")
        highlight OverLength guibg=#2a2a2a
    else
        highlight OverLength ctermbg=233
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
" set textwidth=79
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

set history=100        " history last command 
set undolevels=100

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

filetype off
filetype plugin indent on
syntax on             " syntax highlight

" move code blocks indents
vnoremap < <gv
vnoremap > >gv

" map leader
let mapleader = ','

" File 
" ===================================================================
"autocmd BufNewFile,BufRead *.dbk  setlocal filetype=docbk
"autocmd BufNewFile,BufRead *.docbook  setlocal filetype=docbk
"autocmd BufNewFile,BufRead *.t2t setlocal filetype=txt2tags
"autocmd BufNewFile,BufRead *.rst setlocal filetype=ReST
" autocmd BufNewFile,BufRead *.html setlocal filetype=html
autocmd BufNewFile,BufRead *.txt setlocal filetype=text

" file template
autocmd BufNewFile *.rst 0read ~/.vim/templates/skeleton.rst

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
autocmd FileType rst setlocal syntax=rest
autocmd FileType rst setlocal spell spelllang=en_us
autocmd FileType rst setlocal makeprg=rst2html.py\ --cloak-email-addresses\ %\ %.html;firefox\ %.html
"autocmd FileType rst setlocal errorformat=%m\ in\ %f\ on\ line\ %l
" txt
"autocmd FileType txt setlocal wrap

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

" Move between tabs
" gt to previous tab
" gT to next tab
" map <Leader>n   <esc>:tabprevious<cr>
" map <Leader>m   <esc>:tabnext<cr>


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
" :reg   " to display all registers content
" share vim clipboard and system clipboard
" set clipboard=unnamedplus     " for + register
" set clipboard=unnamed         " for * register
"
" :map  " to display current keymaps
" :verbose map <key>    " to display map script
" i_CTRL-V_digit| CTRL-V {number} insert three digit decimal number as a single
"
" Make shift-insert work like in Xterm, paste
" paste
map  <S-Insert>  "+gP
map! <S-Insert>  "+gP
" copy
map <C-Insert>   "+y
"vnoremap <C-Insert>   "+y
" cut
vnoremap <S-Del>      "+x

" compile
noremap  <F9> :update<CR>:silent! make<CR>
noremap! <F9> <ESC>:update<CR>:silent! make<CR>

" run
"map <F5> <ESC>:w<CR>:!/usr/bin/python %<CR>
"
" VIM Plugins 
" ==========================================================================
" pathogen.vim
" ==========================================================================
" https://github.com/tpope/vim-pathogen
" mkdir -p ~/.vim/autoload ~/.vim/bundle; \
" curl -Sso ~/.vim/autoload/pathogen.vim \
"    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Add third module as submodule
" cd ~/
" git submodule add git@github.com:kien/ctrlp.vim.git .vim/bundle/ctrlp.vim
" git add -f .vim/bundle/ctrlp.vim/
" Remove third module
" rm -rf .vim/bundle/xxx.vim
" git rm -r .vim/bundle/xxx.vim
" Update third module
" git submodule foreach 'git pull'
set noshowmode
call pathogen#infect()
call pathogen#helptags()

" powerline
" ==========================================================================
" git clone https://github.com/Lokaltog/powerline
" cd powerline
" sudo python setup.py install
" for bash
" . {path}/powerline/bindings/bash/powerline.sh
" for tmux
" set -g default-terminal screen-256color
" source '{path}/powerline/bindings/tmux/powerline.conf'
" for vim
" cd ~/.vim/bundle
" ln -s /usr/lib/python2.6/site-packages/Powerline-beta-py2.6.egg/powerline/bindings/vim powerline
" let g:Powerline_symbols = 'fancy'

" c/c++ mode
" http://www.vim.org/scripts/script.php?script_id=213
" download cvim.zip
" mkdir -p ~/.vim/bundle/cvim
" cd ~/.vim/bundle/cvim
" unzip ~/Downloads/cvim.zip
" filetype plugin on

" python-mode
" =============================================================================
" https://github.com/klen/python-mode
" cd ~/.vim/bundle; git clone https://github.com/klen/python-mode
" :RopeCreateProject    # create ropeproject
map <Leader>g :call RopeGotoDefinition()
let ropevim_enable_shortcuts=1
let g:pymode_rope_goto_def_newwin="vnew"
let g:pymode_rope_extended_complete=1
let g:pymode_rope_map_space=0   " conflict with scim and ibus input method
inoremap <C-o>  <C-r>=RopeCodeAssistInsertMode()<CR>
" let g:ropevim_autoimport_modules=["os","shutil","datetime","django"]
let g:pymode_lint_checker="pyflakes, pep8, mccabe"  " pylint, pyflakes, pep8, mccabe
let g:pymode_breakpoint=0
let g:pymode_syntax=1
let g:pymode_syntax_builtin_objs=0
let g:pymode_syntax_builtin_funcs=0
" install ipython and ipdb firstly
map <Leader>b Oimport ipdb; ipdb.set_trace()    # BREAKPOINT<C-c>

" ctrlp - a finder for VIM 
" =============================================================================
" https://github.com/kien/ctrlp.vim
" cd ~/.vim/bundle; git clone https://github.com/kien/ctrlp.vim.git
" <C-p> to activate
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*.so
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" python_editing
" ===================================================================
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
" <f> to fold current function
" <F> to fold all function
" set nofoldenable      " not support in  vi

" printer
" ===================================================================
" prtdialog <http://www.vim.org/scripts/script.php?script_id=512>
" <Leader>pd  to configure printer options
set printoptions=paper:A4,portrait:y,duplex:long,wrap:y,number:y,syntax:n
"  
"set printmbcharset=utf-8
"set printmbfont=WenQuanYi\ Zen\ Hei

" rst_table
" ===================================================================
" wget -O ~/.vim/plugin/rst_table.vim http://www.vim.org/scripts/download_script.php?src_id=12783
" ,,c  ->  Creates a new restructuredText table.
" ,,f  ->  Fix table columns in a table. 

" taglist
" =================================================================== 
" configure Ctags
if has("unix")
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
else
    let Tlist_Ctags_Cmd = '"'.$VIM.'/ctags.exe"'
endif
" :TlistToggle<CR>  to show Tlist
map <Leader>tl <ESC>:TlistToggle<CR>
" show current file tag
let Tlist_Show_One_File=1
" exit vim when only tag window
let Tlist_Exit_OnlyWindow=1
" show tag list on right window
let Tlist_Use_Right_Window=1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 0
let Tlist_Compact_Format = 0
let Tlist_Display_Prototype = 0
let Tlist_Display_Tag_Scope = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_File_Fold_Auto_Close = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Max_Submenu_Items = 1
let Tlist_Max_Tag_Length = 30
let Tlist_Process_File_Always = 0
let Tlist_Show_Menu = 0
let Tlist_Sort_Type = "order"
let Tlist_Use_Horiz_Window = 0
let Tlist_WinWidth = 31

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


