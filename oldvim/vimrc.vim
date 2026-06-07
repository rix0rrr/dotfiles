"----------------------------------------------------------------------
" rix0r's .vimrc
"
" The file is divided into sections, and all commands are commented. If you
" want to copy anything, feel free to do so.
"
" This vimrc file should be cross-platform compatible between Windows and
" Linux. On Linux, the .vimrc file is a symlink to the _vimrc file from my
" repository.
"----------------------------------------------------------------------

"----------------------------------------------------------------------
"  BOOTSTRAPPING
"----------------------------------------------------------------------

"if &shell =~# 'fish$'
    set shell=/bin/bash
"ndif

set nocompatible
filetype off
set rtp+=~/Dropbox/Vim/Vimfiles
set rtp+=~/Dropbox/Vim/bundle/vundle/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"----------------------------------------------------------------------
"  BUNDLES
"----------------------------------------------------------------------

" Vundle bundles

" Commenting in/out
Plugin 'scrooloose/nerdcommenter'
" Syntax check
" Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
" Status line
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Colorscheme (all colorschemes!)
Plugin 'flazz/vim-colorschemes'
" Session
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
" EasyAlign (:EasyAlign)
Plugin 'junegunn/vim-easy-align'
" Outline (needs <apt-get | brew> install exuberant-ctags)
Plugin 'majutsushi/tagbar'
" YCM!
" Plugin 'Valloric/YouCompleteMe'
" ProjectRoot
Plugin 'dbakker/vim-projectroot'
" Ctrl-P file management
Plugin 'kien/ctrlp.vim'
" Java IDE
"Plugin 'dansomething/vim-eclim'
" Languages
Plugin 'vim-scripts/Cpp11-Syntax-Support'
Plugin 'lorin/vim-alloy'
Plugin 'rix0rrr/vim-gcl'
Plugin 'rust-lang/rust.vim'
Plugin 'dag/vim-fish'
Plugin 'leafgarland/typescript-vim'

" EditorConfig
Plugin 'editorconfig/editorconfig-vim'
" Rope-Vim
"Plugin 'python-rope/ropevim'
" Drawing
Plugin 'vim-scripts/DrawIt'
" Fancy
Plugin 'jaxbot/semantic-highlight.vim'
" Tim Pope is the man!
Plugin 'tpope/vim-abolish'
" Renamer
Plugin 'qpkorr/vim-renamer'


" Load the Google Vim plugin if available
if filereadable("/usr/share/vim/google/google.vim")
    source /usr/share/vim/google/google.vim

    " Glug bundles
    " YCM!
    Glug youcompleteme-google
    " Auto-checkout
    Glug g4
    " Syntastic Google plugin
    Glug syntastic-google

    " Outline
    Glug outline-window
    nnoremap ,g :GoogleOutlineWindow<CR>
endif

call vundle#end()

syntax enable
filetype plugin indent on

"----------------------------------------------------------------------
"  START OF REGULAR VIMRC
"----------------------------------------------------------------------

" If we're running in GUI mode, switch to Windows-like behaviour.
" Motivation: Ctrl-V (block select) is Ctrl-Q in Windows mode, but you can't
" use Ctrl-Q in a terminal (it has a special meaning), which is what I'm
" running vim on if not in GUI. So we need to load it *only* in GUI mode.
if has("gui_running")
    " source $VIMRUNTIME/mswin.vim
    " behave mswin
endif

if has("gui_macvim")
  " Remove existing icons from touch bar
  aunmenu TouchBar.
endif

" Use comma as leader since it's easier to hit
let maplocalleader = ","

"----------------------------------------------------------------------
" UI APPEARANCE
"----------------------------------------------------------------------

colorscheme desert
set visualbell

if has("gui_running")
    " Remove the annoying toolbar in GUI mode.
    set guioptions-=T
    " Disable the GUI menu bar
    set guioptions-=m
endif

" Some tweaks for my Windows machines
if has("win32")
    " FIXME: This might be done nicer with a site-include...

    " Set a nicer font (Inconsolata XL, needs to be downloaded), fall back
    " to Consolas otherwise.
    set guifont=Consolas:h11

    " Hit Window Maximize when entering GUI mode
    " Discriminate between my laptop (which is running a Dutch Windows) and my
    " home computer (which is running an English one)
    if filereadable(expand("~/dutch"))
        au GUIEnter * simalt ~m
    else
        au GUIEnter * simalt ~x
    endif
elseif has("mac") && has("gui_running")
    "set guifont=Monaco:h13
    if g:Retina
        set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h16
    else
        set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h14
    endif
endif

" Don't replace lines that don't fit on the screen with @@@'s
set display+=lastline

"----------------------------------------------------------------------
" EDITING FEEDBACK
"----------------------------------------------------------------------

" When typing a closing bracket, briefly flash the one it matches.
set showmatch
set matchtime=1

set showcmd                  " Show (partial) command in status line.
set history=50               " keep 50 lines of command line history
set ruler                    " show the cursor position all the time
set nowrap                   " Screen wrapping continually annoys me
"set printfont=courier_new:h8 " Small print font (for when I'm printing code...)
set encoding=utf8            " I don't want to see any non-utf8 file in my life anymore

" Diffing (use :diffthis to start comparing buffers)
set diffopt+=iwhite

syntax on

set incsearch                    " Search incrementally.
set ignorecase                   " Ignore case when searching.
set smartcase                    " Except when a mix of case is given.
set hlsearch                     " Highlight search hits

" Ctrl+H to remove search highlights after I don't need 'em anymore.
" Only in gVim; in the console, this binding conflicts with backspace.
if has("gui_running")
    nmap <C-U> :nohlsearch<CR>
    imap <C-U> <ESC><C-U>
endif

command! Diff 1winc w | diffthis | 2winc w | diffthis

"----------------------------------------------------------------------
" FOLDING
"----------------------------------------------------------------------

set foldlevel=20             " Folds will be open initially.
set foldnestmax=20

"----------------------------------------------------------------------
" EDITING BEHAVIOR
"----------------------------------------------------------------------

set tw=120
set backspace=indent,eol,start      " Allow backspacing everywhere.

" Make Ctrl-Backspace do what I'm used to (erase entire word)
imap <c-bs> <c-w>
imap <c-del> <c-w>

" Do indenting with Tab and Shift-Tab like I'm used to,
" keeping the lines selected
vmap <Tab>   >gv
vmap <S-Tab> <gv
nmap <Tab>   <S-V><Tab>
nmap <S-Tab> <S-V><S-Tab>
imap <S-Tab> <ESC><S-Tab>

" Ctrl-U does word swap forward, Shift-Ctrl-U does word swap backward
"nmap <C-u> daWWPB
"imap <C-u> <ESC><C-u>
"nmap <C-U> dawBP
"imap <C-U> <ESC><C-U>

" Pressing up in a long line gets you to the above line "in the screen", etc.
noremap j gj
noremap k gk

" Reflow a block of text with Ctrl-Y.
nmap <C-Y> gqap
imap <C-Y> <ESC>gqap
vmap <C-Y> gq

" Do default formatting, but also don't autoformat while I'm inserting (l)
set formatoptions=tcql

" On a TouchBar MacBook I have to find an alternative for ESC
inoremap jk <esc>
inoremap jj <esc>

"----------------------------------------------------------------------
" FILES
"----------------------------------------------------------------------

" Backup and swap files are annoying
set nobackup
set noswapfile
set autoread                        " Reload files that have been modified outside of vim.

filetype plugin on

" Save with Ctrl-S (and Cmd-S on the Mac)
nmap <C-S> :w<CR>
vmap <C-S> <ESC><C-S>gv
imap <C-S> <ESC><C-S>
if has("mac")
    nmap <D-S> :w<CR>
    vmap <D-S> <ESC><D-S>gv
    imap <D-S> <ESC><D-S>
endif

autocmd BufNewFile,BufRead *.less set filetype=css
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.pb2 set filetype=textpb
autocmd BufNewFile,BufRead *.ts set filetype=typescript

" Match parens, but disable on large files
autocmd BufRead * if getfsize(bufname("%")) > 100000 | exe "NoMatchParen" | endif

autocmd FileType python              set cinwords=if,elif,else,for,while,try,except,finally,def,class

" Strip trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Align text on new lines to open parens (using cindent)
set cino=(0

" Search for 'tags' files in the current dir and then up till the root
set tags=./tags;/,tags;/

" Switch between source and header files in C++
nmap ,s :silent execute "e " . system("find " . ProjectRootGuess() . " -name " . expand("%:t:r") . ".cpp")<CR>
nmap ,S :silent execute "vert e " . system("find " . ProjectRootGuess() . " -name " . expand("%:t:r") . ".cpp")<CR>
nmap ,h :silent execute "e " . system("find " . ProjectRootGuess() . " -name " . expand("%:t:r") . ".h")<CR>
nmap ,H :silent execute "vert e " . system("find " . ProjectRootGuess() . " -name " . expand("%:t:r") . ".h")<CR>

" Copy current filename to clipboard
nmap ,f :let @+ = expand("%")<CR>

"----------------------------------------------------------------------
" TABBING
"----------------------------------------------------------------------

" Set default indent level to 4
set tabstop=4 shiftwidth=4 softtabstop=4

" But use 2 for LaTeX files
autocmd FileType tex set tabstop=2 shiftwidth=2 softtabstop=2

" Python has 2 spaces of indentation
autocmd FileType python set tabstop=2 shiftwidth=2 softtabstop=2

" CPP has 4 spaces
autocmd FileType cpp,cpp11 set tabstop=4 shiftwidth=4 softtabstop=4

set shiftround                      " Round shifting off to multiples of shiftwidth
set autoindent                      " Autoindent is nice.
set expandtab                       " I don't want tabs, I want spaces

nmap <F2> :set tabstop=2 shiftwidth=2 softtabstop=2<CR>:echo 'Indent set to 2'<CR>
nmap <F3> :set tabstop=4 shiftwidth=4 softtabstop=4<CR>:echo 'Indent set to 4'<CR>

"----------------------------------------------------------------------
" BUFFERS & TABS & STUFF
"----------------------------------------------------------------------

" Close buffer, try really hard not to close the window
"map ,b :bp<bar>sp<bar>bn<bar>bd<CR>

" Using Command-{} to switch between MiniBufExplorer tabs
" On Windows/Linux machines, use Alt, since that's in the same spot as Command
" and very comfortable to reach.
"
" MacVim: This needs disabling of these menu items in MacVim's menu.vim,
" otherwise they'll take precedence
"nmap <C-H> 1<C-w>wh<CR>
"nmap <C-L> 1<C-w>wl<CR>
"
if has("mac")
    " Mac
    if has('gui_vimr')
        nmap <D-{> :tabnext<CR>
        nmap <D-}> :tabprevious<CR>
    else
        nmap <D-{> :bp!<CR>
        nmap <D-}> :bn!<CR>
    endif
    imap <D-{> <ESC><D-{>
    imap <D-}> <ESC><D-}>
    "nmap <D-w> <C-K>d
else
    if has("gui_running")
        " Windows or Linux gVim
        nmap <A-{> :bp!<CR>
        nmap <A-}> :bn!<CR>
        imap <A-{> <ESC><A-{>
        imap <A-}> <ESC><A-}>
        "nmap <C-w> <C-K>d
    else
        " Terminal, use terminal escape sequences
        nmap { :bp!<CR>
        nmap } :bn!<CR>
        imap { <ESC>:bp!<CR>
        imap } <ESC>:bn!<CR>

        " Or if we're in tmux, map accolades
        nmap { :bp!<CR>
        nmap } :bn!<CR>
    endif
endif

" Move windows using ^H^J^K^L
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l

" Delete buffer without losing split with C-D
nnoremap <C-d> :b#\|bd #<CR>

" Switch between buffers with Alt-# bindings (however, since buffer numbers
" are not reused this will only remain useful for a short while...)
set hidden
if has("mac")
    " Cmd-# window bindings
    nmap <D-1> :buffer! 1<CR>
    nmap <D-2> :buffer! 2<CR>
    nmap <D-3> :buffer! 3<CR>
    nmap <D-4> :buffer! 4<CR>
    nmap <D-5> :buffer! 5<CR>
    nmap <D-6> :buffer! 6<CR>
    nmap <D-7> :buffer! 7<CR>
    nmap <D-8> :buffer! 8<CR>
    nmap <D-9> :buffer! 9<CR>
    nmap <D-0> :buffer! 10<CR>
    nmap <D--> :buffer! 11<CR>
    nmap <D-=> :buffer! 12<CR>
    " Insert mode
    imap <D-1> <ESC><D-1>
    imap <D-2> <ESC><D-2>
    imap <D-3> <ESC><D-3>
    imap <D-4> <ESC><D-4>
    imap <D-5> <ESC><D-5>
    imap <D-6> <ESC><D-6>
    imap <D-7> <ESC><D-7>
    imap <D-8> <ESC><D-8>
    imap <D-9> <ESC><D-9>
    imap <D-0> <ESC><D-0>
    imap <D--> <ESC><D-->
    imap <D-=> <ESC><D-=>
else
    " Define key bindings to go directly to the selected window
    " Normal mode
    nmap <A-1> :buffer! 1<CR>
    nmap <A-2> :buffer! 2<CR>
    nmap <A-3> :buffer! 3<CR>
    nmap <A-4> :buffer! 4<CR>
    nmap <A-5> :buffer! 5<CR>
    nmap <A-6> :buffer! 6<CR>
    nmap <A-7> :buffer! 7<CR>
    nmap <A-8> :buffer! 8<CR>
    nmap <A-9> :buffer! 9<CR>
    nmap <A-0> :buffer! 10<CR>
    nmap <A--> :buffer! 11<CR>
    nmap <A-=> :buffer! 12<CR>
    " Insert mode
    imap <A-1> <ESC><A-1>
    imap <A-2> <ESC><A-2>
    imap <A-3> <ESC><A-3>
    imap <A-4> <ESC><A-4>
    imap <A-5> <ESC><A-5>
    imap <A-6> <ESC><A-6>
    imap <A-7> <ESC><A-7>
    imap <A-8> <ESC><A-8>
    imap <A-9> <ESC><A-9>
    imap <A-0> <ESC><A-0>
    imap <A--> <ESC><A-->
    imap <A-=> <ESC><A-=>
    " Keyboard remappings to make alt-# work in a terminal
    set <A-1>=1
    set <A-2>=2
    set <A-3>=3
    set <A-4>=4
    set <A-5>=5
    set <A-6>=6
    set <A-7>=7
    set <A-8>=8
    set <A-9>=9
    set <A-0>=0
endif

set splitbelow
set splitright

"----------------------------------------------------------------------
"  NERDCOMMENTER
"----------------------------------------------------------------------
vnoremap ,c :call NERDComment('x', 'toggle')<CR>

"----------------------------------------------------------------------
"  AIRLINE
"----------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme = 'bubblegum'
set laststatus=2

if has("gui_running")
    " Airline/powerline symbols
    if !exists('g:airline_symbols')
    let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''

    if has("x11")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
    endif
endif

"----------------------------------------------------------------------
" VIMSESSION
"----------------------------------------------------------------------

" Keep session in current directory
let g:session_default_name = 'default'
let g:session_autosave_periodic = 5
let g:session_autosave = 'yes'
let g:session_autoload = 'no'

" If you don't want help windows to be restored:
set sessionoptions-=help

"----------------------------------------------------------------------
" VIMCLOJURE
"----------------------------------------------------------------------
let g:vimclojure#ParenRainbow=1
let g:vimclojure#WantNailgun=1
let g:vimclojure#NailgunClient="ng"
let g:vimclojure#SplitPos="bottom"
let g:vimclojure#SplitSize=10

"----------------------------------------------------------------------
" TAGBAR
"----------------------------------------------------------------------

nmap ,t :TagbarOpen<CR>:TagbarShowTag<CR>

"----------------------------------------------------------------------
" CTRL-P
"----------------------------------------------------------------------

set wildignore+=*.pyc,*.po,*.csv
let g:ctrlp_custom_ignore = 'tags\|DS_Store\|git\|CMakeFiles\|\.log$\|\.dce$\|\.req$\|\.repl$\|.*/node_modules/.*\|\.notify$'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files=20000
let g:ctrlp_max_depth=10

"----------------------------------------------------------------------
" EditorConfig
"----------------------------------------------------------------------

let g:EditorConfig_max_line_indicator = 'none'


"----------------------------------------------------------------------
" EasyAlign
"----------------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga*<space>)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"----------------------------------------------------------------------
" PROGRAMMING VIMRC
"----------------------------------------------------------------------

if has("win32")
    " Set the name of the vimrc file on Windows (needed later on)
    let g:Vim_RcFileName=$VIM . "/_vimrc"
else
    " Set the name of the vimrc file on *NIX (needed later on)
    let g:Vim_RcFileName="~/Dropbox/Vim/vimrc.vim"
endif

" A mapping to open the .vimrc file
nmap <F7> :e <C-R>=g:Vim_RcFileName<CR><CR>
imap <F7> <ESC><F7>
" A mapping to reload the .vimrc file
nmap <F8> :source <C-R>=g:Vim_RcFileName<CR><CR>:echo 'vimrc reloaded'<CR>
imap <F8> <ESC><F8>

"----------------------------------------------------------------------
" KAASLIJSTJEFIXERT
"----------------------------------------------------------------------
function! KaaslijstjeFixer()
    set tw=70
    set ft=
    silent! %s/^[> \t]\+//g
    normal gggqG
    silent! %s/\n\n\n/\r\r/g
endfunction
com! -nargs=0 FixKaas call KaaslijstjeFixer()

"----------------------------------------------------------------------
" LINTING AND AUTOLINTING
"----------------------------------------------------------------------

" This changes both autolinting and swapfile writing, but we're not doing
" the latter anyway.
set updatetime=5000

function! s:GPyLint(jump)
  echo "Linting..."
  let a:lint = '/usr/bin/gpylint '
    \. '--include-ids --single-file=y -f text '
    \. '--msg-template="{path}:{line}: [{msg_id}({symbol})] {msg}"'
  if a:jump
      cexpr system(a:lint . ' ' . expand('%'))
      botright cwindow
  else
      cgetexpr system(a:lint . ' ' . expand('%'))
  endif
  echo ""
endfunction

function! s:AutoLint()
    " Call PyLint every g:autolint_interval milliseconds
    let ft = &filetype
    if ft == 'python'
        call s:GPyLint(0)
        botright cwindow
    endif
endfunction

au FileType python command! Lint :call s:GPyLint(1)
"au CursorHold * call s:AutoLint()

au FileType log set foldmethod=marker foldlevel=0 foldcolumn=2
au FileType javascript set nocindent

"----------------------------------------------------------------------
" MAKE AND QUICKFIX
"----------------------------------------------------------------------
" Ctrl-M to search the project root for 'lint.sh', execute it, and populate
" the quickfix buffer with the results.
" ]q and [q to cycle through the quickfix entries

function! FindMake()
"    let file = ProjectRootGuess() . '/lint.sh'
"    echo file
"    if filereadable(file)
"        cexpr system(file)
"        botright cwindow
"        normal <C-W><C-P>
"    endif
    cexpr system("brazil-build --cc-only test")
    botright cwindow
    normal <C-W><C-P>
endfunction

"map <C-M> :call FindMake()<CR>
nmap ]q :cnext<CR>
nmap [q :cprevious<CR>

"----------------------------------------------------------------------
" YouCompleteMe! bindings
"----------------------------------------------------------------------
nmap ,g :YcmCompleter GoToDefinition<CR>
nmap ,jd :YcmCompleter GoToDeclaration<CR>
nmap ,je :YcmCompleter GoToDefinition<CR>
nmap ,ji :YcmCompleter GoToInclude<CR>

let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_extra_conf_vim_data = ['getcwd()']
"let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
"let g:ycm_server_python_interpreter = '/usr/bin/python'
"let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
"set completeopt-=preview
let g:ycm_always_populate_location_list = 1

" Make sure that we always show the sign column in C++ files, so it doesn't jank
" back and forth.
autocmd FileType cpp sign define dummy
autocmd FileType cpp execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

"----------------------------------------------------------------------
" NERDTree bindings
"----------------------------------------------------------------------
nmap ,e :NERDTreeFocus<CR>

"----------------------------------------------------------------------
" Ctrl-P bindings
"----------------------------------------------------------------------
map <C-B> :CtrlPBuffer<CR>
nmap ,b :CtrlPBuffer<CR>

"----------------------------------------------------------------------
" FILETYPES
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" COLORED EXPORT
"----------------------------------------------------------------------

function! Clip()
    set background=light
    colorscheme papercolor
    syntax on
    set guifont=Monaco:h18
    TOhtml
    silent w !htmlcopy
    bd!
endfunction

command! Clip call Clip()

" Colorize for Amazon
function! ClipEmail()
    colorscheme whitebox
    syntax on
    TOhtml
    silent w !htmlcopy
    bd!
endfunction

command! ClipEmail call ClipEmail()

"----------------------------------------------------------------------
" Get the current filename and line into the clipboard for use in GDB breakpoints
"----------------------------------------------------------------------
nmap ,z :let @+=expand("%:t") . ':' . line(".")<CR>
nmap ,Z :let @+=expand("%:p")<CR>

nmap ,o :.s/\%u001d/\r/g<CR>
vmap ,o :s/\%u001d/\r/g<CR>

"----------------------------------------------------------------------
" Switch to a mode where I just type bunches of text in Vim
"----------------------------------------------------------------------
function! Prose()
    set wrap linebreak textwidth=0
endfunction

"----------------------------------------------------------------------
" Respect indentation levels on pasting
"----------------------------------------------------------------------
"nnoremap p ]p
"if has("gui_running")
"    nnoremap <C-V> "+[p
"    imap <ESC><C-V>
"endif

"----------------------------------------------------------------------
" Respect different text width in git commits
"----------------------------------------------------------------------
autocmd FileType gitcommit set tw=72

"----------------------------------------------------------------------
" Get a GitHub link for a line of code
"----------------------------------------------------------------------
function! GitHubLine()
    call system('copyline ' . expand('%:p') . ' ' . line('.'))
endfunction

command! GitHubLine call GitHubLine()

"----------------------------------------------------------------------
" BIGGER TEXT FOR SCREEN SHARING
"----------------------------------------------------------------------

function! Bigger()
    set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h28
endfunction

command! Bigger call Bigger()

"----------------------------------------------------------------------
" Command-P to control P. Who ever prints?
"----------------------------------------------------------------------

nnoremap <D-P> <C-P>

"----------------------------------------------------------------------
" Neovide settings
"----------------------------------------------------------------------

" Cursor animation is annoying
let g:neovide_cursor_animation_length=0
