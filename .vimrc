" LGM's vimrc based on http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
 
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

call plug#begin('~/.vim/plugged')
" A fancy status line.
Plug 'vim-airline/vim-airline'
" Themes for airline
Plug 'vim-airline/vim-airline-themes'
"nifty file tree navigation stuff.
Plug 'scrooloose/nerdtree'
" a tag baar
Plug 'majutsushi/tagbar'
" handy commenting shortcuts
Plug 'scrooloose/nerdcommenter'
" color schemes!
Plug 'flazz/vim-colorschemes'
" extra nice to have c related stuff
Plug 'WolfgangMehner/c-support'
" buffer explorer
Plug 'jlanzarotta/bufexplorer'
" show marks in the gutter for convenience
Plug 'kshenoy/vim-signature'
" session thingy.
Plug 'mhinz/vim-startify'
" keyword context plugin
Plug 'wesleyche/SrcExpl'
" useful paired commands
Plug 'tpope/vim-unimpaired'
"arduino syntax support"
Plug 'sudar/vim-arduino-syntax'
" LaTex support
Plug 'vim-latex/vim-latex'
" Source Explorer
Plug 'wesleyche/SrcExpl'
" ctrlp"
Plug 'ctrlpvim/ctrlp.vim'
" Plugin to build call tree based on Cscope.
Plug 'hari-rangarajan/CCTree'
" a search plugin
Plug 'rking/ag.vim'
call plug#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on

"set the encoding
set encoding=utf-8

" airline fonts!
let g:airline_powerline_fonts = 1
set guifont=Inconsolata\ for\ Powerline:h11
set t_Co=256
colorscheme dante
" set the gutter to be the same color as the main background.
highlight clear SignColumn
"set a pseudo filetype upon opening a buffer if filetype is not set
autocmd BufRead, BufNewFile * setfiletype txt
autocmd FileType txt call PlainText()

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" EITHER the entire 81st column, full-screen...
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
 
"------------------------------------------------------------
" Startify Options {{{1
let g:startify_session_persistence = 1
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" redraw only when we need to
set lazyredraw

" Enable use of the mouse for all modes
"set mouse=a
 
" Set the command window height to 1 
set cmdheight=1
 
" Display line numbers on the left
set number

" Highlight current line
set cursorline

colorscheme dante
" highlight matching [{()}]
set showmatch

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F10> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F10>
 
" allow modelines
set modelines=1
set modelines=5

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Set cursorline to be underline insetad of highlighting the line.
    augroup CustomCursorLine
        au!
        au ColorScheme * :hi! clear CursorLine
        au ColorScheme * :hi! CursorLine gui=underline cterm=underline 
    augroup END
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

    augroup END

else
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
  set autoindent                " always set autoindenting on
endif " has("autocmd")
"-----------------------------------------------------------
"Backup {{{1
set backup
set backupdir=~/.vim/vim_tmp
set directory=~/.vim/vim_tmp/,~/.vim/tmp
set writebackup

"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
"------------------------------------------------------------
" Folding setup {{{1
set foldmethod=syntax
set foldnestmax=6
set nofoldenable
set foldlevel=2
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
"map arrow keys to movement of text in normal mode to break 
"habit of using them
"move text up
nmap <Up> [e
vmap <Up> [egv
imap <Up> <Nop>
"move text down
nmap <Down> ]e
vmap <Down> ]egv
imap <Down> <Nop>
"move text left
nmap <Left> <<
vmap <Left> <gv
imap <Left> <Nop>
"move text right
nmap <Right> >> 
vmap <Right> >gv
imap <Right> <Nop>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
nnoremap Y y$

" move vertically by visual line instead of actual line.
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

"Map for tagbar
nnoremap <F8> :TagbarToggle<CR>
" map to move lines up (-) and down (_). 
nnoremap - ddp
nnoremap _ ddkP
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
 
"" Map keys for bufexplore explore/next/previous - AltF12/F12/Shifit-F12
nnoremap <silent> <M-F12> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>

"break the
" <c-u> to turn the current word uppercase while in insert mode.
inoremap <c-u> <esc>bveUi

" jk to escape
inoremap jk <esc>

" This rewires n and N to do the highlighing...
nnoremap <silent> n   nzz:call HLNext(0.4)<cr>
nnoremap <silent> N   Nzz:call HLNext(0.4)<cr>

"====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode "]======

nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

nmap  ;s     :set invspell spelllang=en<CR>
" ----- mappings that require <leader> ---
 
" Set leader to ,
let mapleader = ","

" Map  key to open/close nerdtree
nnoremap <leader>f :NERDTreeToggle<enter>

" Reformat current buffer with Astyle -must have .astylerc in working directory
nnoremap <leader>rf :execute "!AStyle.exe --style=bsd -s4 -xV -xW -M40 -p -xd -k3 -xb  -j -c -z2 ". bufname("%")<cr>

" save the current set of windows as a session. 
nnoremap <leader>s :mksession!<CR>

"open this vimrc in a vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" surround current word in double quotes
nnoremap <leader> viw<esc>a"<esc>bi"<esc>lel

"source this vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

" Map c-support indent command
nnoremap <leader>in :call csupport-run-indent()<CR>
" Map some CCTree keys:
nnoremap <leader>tr :CCTreeTraceReverse<CR>
nnoremap <leader>tf :CCTreeTraceForward<CR>
nnoremap <leader>tt :CCTreeWindowToggle<CR>

" Toggle the quickfix pane
nnoremap <leader>q :call ToggleQuickFix()<CR>

" toggle between absolute and relative line numbers
nnoremap <leader>n :call ToggleNumber()<CR>

" change working directory to current file
nnoremap <leader>cd :cd %:p:h<CR>
"
nnoremap <leader>ctag :!ctags --sort=foldcase -R .
"nnoremap <leader>ctag :!ctags --sort=foldcase -R . C:/FreeRTOSv9.0.0/FreeRTOS/Source C:/ti/simplelink_cc32xx_sdk_1_50_00_06/source/ti/drivers<CR>

"nnoremap <leader>mct :!ctags --sort=foldcase -R . C:\Working\M099\Software\C C:/FreeRTOSv9.0.0/FreeRTOS/Source C:/ti/simplelink_cc32xx_sdk_1_50_00_06/source/ti/drivers<CR>
"-----------------------------------------------------------
" abbreviations {{{2

iabbrev teh the
iabbrev tehn then
iabbrev copyr Copyright     Vislink Technologies, Inc.
iabbrev lenght length
"-----------------------------------------------------------
" snippet mappings {{{2
nnoremap <leader>func :-1read ~\.vim\.skeleton.doxygen_function_header<CR>
nnoremap <leader>file :read ~\.vim\.skeleton.doxygen_file_header<CR>

" airline settings {{{1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_theme='papercolor'
let g:airline_theme='murmur'

"-----------------------------------------------------------
" NERDTree autostart(see NERDTree readme) {{{1
"augroup nerdgroup
    "autocmd!
    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"augroup END
"-----------------------------------------------------------
" NERDTree settings {{{1
let NERDTreeQuitOnOpen = 1
" auto delete buffer of file deleted with NERDTree
let NERDTreeAutoDeleteBuffer = 1
" show dot files
let NERDTreeShowHidden=1

"-----------------------------------------------------------
" SourceExplorer Settings {{{1

" toggle source explorer on/off
nnoremap <F7> :SrcExplToggle<CR>

" set the height of the source explorer window
let g:SrcExpl_winHeight=8

" set refresh time in ms for Source Explorer
let g:SrcExpl_refreshTime = 100

" Set <ENTER> to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"

" set <SPACE> to jump back 
let g:SrcExpl_gobackKey = "<SPACE>"

" we need to let source explorer know what plugins are using buffers according
" to :buffers!
let g:SrcExpl_pluginList = [
        \ "__Tagbar__.1",
        \ "NERD_tree_1",
        \ "Source_Explorer"
    \]

" Pick a color scheme for Source Explorer from the list of 
" Red, Cyan, Green, Yellow, and Magenta.
let g:SrcExpl_colorSchemeList = [
        \ "Red",
        \"Green",
    \]

" // Workaround for Vim bug @https://goo.gl/TLPK4K as any plugins using autocmd for
" // BufReadPre might have conflicts with Source Explorer. e.g. YCM, Syntastic etc.
let g:SrcExpl_nestedAutoCmd = 1

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update the tags file 
let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase -a -R .'
" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<F6>" 

" // Set "<F3>" key for displaying the previous definition in the jump list 
let g:SrcExpl_prevDefKey = "<F3>" 

" // Set "<F4>" key for displaying the next definition in the jump list 
let g:SrcExpl_nextDefKey = "<F4>"
"-----------------------------------------------------------
" Ctrl-P settings {{{1

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'
"-----------------------------------------------------------
" Cscope {{{1
"if has('cscope')
    "set cscopetag cscopeverbose

    "if has('quickfix')
        "set cscopequickfix=s-,c-,d-,i-,t-,e-
    "endif

    "cnoreabbrev csa cs add
    "cnoreabbrev csf cs find
    "cnoreabbrev csk cs kill
    "cnoreabbrev csr cs reset
    "cnoreabbrev css cs show
    "cnoreabbrev csh cs help

    "command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
"endif
"-------------------------------------------------------------
" Custom functions {{{1

function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

let g:quickfix_is_open = 0

function! ToggleQuickFix()
    if(g:quickfix_is_open)
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunc

"highlight the match in red...
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('ErrorMsg', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

function! PlainText()
    "We don't have a notion of comments in plain text.
    ""this also allows the use of '*' in formastlistpat
    setlocal comments=
    "use commentstring for quoting
    setlocal commentstring=>\ %s
    setlocal spell
    setlocal wrap
    setlocal textwidth=80
    setlocal linebreak
    setlocal breakindent
endfunction
"------------------------------------------------------}}}
" vim: set foldmarker={{{,}}} foldmethod=marker foldlevel=0 foldenable :
