" vim: set foldmethod=marker foldlevel=0:

" PLATFORM SPECIFIC PREFIX {{{
if has("win32") || has("win64")
  let g:bundle_dir=expand("$HOME/vimfiles/bundle")
  set rtp+=$HOME/vimfiles/bundle/vundle
else
  set rtp+=~/.vim/bundle/vundle/
endif
" }}}
" VUNDLE {{{
call vundle#rc()
" Don't forget to :BundleInstall to bootstrap environment!
Bundle 'bling/vim-airline'
Bundle 'ervandew/supertab'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tomasr/molokai'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/nagios-syntax'
Bundle 'vim-scripts/vimwiki'
Bundle 'mrtazz/simplenote.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'wting/rust.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
" }}}
" GOLANG {{{
set rtp+=$GOROOT/misc/vim
" }}}
" CTRLP {{{
:let g:ctrlp_map = '<Leader>cp'
:let g:ctrlp_match_window_bottom = 0
:let g:ctrlp_match_window_reversed = 0
:let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
:let g:ctrlp_working_path_mode = 0
:let g:ctrlp_dotfiles = 0
:let g:ctrlp_switch_buffer = 0
" }}}
" VIMWIKI {{{
let g:vimwiki_folding=0
let g:vimwiki_use_calendar=1
autocmd BufEnter *.wiki set ts=8
autocmd BufEnter *.wiki set sts=4
autocmd BufEnter *.wiki set sw=4
autocmd BufEnter *.wiki set tw=20000
autocmd BufEnter *.wiki set expandtab
" }}}
" MARKDOWN {{{
autocmd BufRead,BufNewFile *.md set filetype=markdown
" }}}
" SCALA CRAP {{{
au BufRead,BufNewFile *.scala set filetype=scala
" }}}
" SETTINGS {{{

" make airline prettery, because why not?
let g:airline_powerline_fonts = 1

" treat simplenote as markdown default
let g:SimplenoteFiletype="markdown"

" make quickfix use existing buffer if present, otherwise spawn a new tab,
" rather than do stupid shit
set switchbuf+=usetab,newtab

" make sure ({}) doesn't error in C++11
let c_no_curly_error=1

set autochdir
set backspace=indent,eol,start
set bk
set bkc=yes " needed in order to preserve application assignment to file in OS X
set complete-=i " don't scan included files (slow)
set completeopt=longest,menu,preview
set diffopt=filler,vertical,iwhite,foldcolumn:2
set display=lastline
set encoding=utf-8
set expandtab
set fileformats=unix,mac,dos
set foldcolumn=1
set foldmethod=manual
set foldminlines=0
set formatlistpat=^\\s*\\(\\d\\+\\\|\\*\\\|-\\\|∙\\\|•\\\|∘\\\|·\\)[]:.)}\\t\ ]\\s*
set formatoptions=croqnl12
set grepprg=grep\ -nH\ $* " my grep supports -H, so I've set it, since options.txt told me to
set guifont=Sauce\ Code\ Powerline:h11
set guioptions=ac
set history=50
set hlsearch
set icon
set ignorecase
set incsearch
set laststatus=2
set linebreak
set listchars=eol:↵,trail:.,extends:>,precedes:<,tab:»·,nbsp:+,trail:·,extends:→,precedes:←
set modeline
set mouse=a
set mousemodel=popup_setpos
set nocompatible " Toto, I've a feeling we're not in Kansas anymore.
set noerrorbells
set nofoldenable
set nomousefocus
set nowrap
set number
set numberwidth=4
set ruler
set scrolloff=3
set shortmess=filmnrwxtI
set showbreak=>
set showcmd
set showmatch
set sidescrolloff=10     
set smartcase
set spelllang=en
set statusline +=%4v\ %*             "virtual column number
set statusline +=%=%5l%*             "current line
set statusline +=%m%*                "modified flag
set statusline +=%{&ff}%*            "file format
set statusline +=%{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\ \"}%* " encoding
set statusline +=/%L%*               "total lines
"set statusline +=\ %y%*              "file type
set statusline +=0x%04B\ %*          "character under cursor
set statusline +=\ %<%F%*            "full path
set statusline +=\ %n\ %*            "buffer number
set statusline=
set sts=2
set sw=2
set title
set ttyfast
set ttymouse=xterm2
set undofile
set undolevels=1000
set undoreload=10000
set viminfo=!,'100,h
set virtualedit=all
set visualbell
set wb
set wildmenu
set wildmode=longest:full
set wmh=0
set wrapscan " wrap when searching
" EOSETTINGS }}}
" AUTOCOMMANDS {{{
" make dealing with gzip files not really a pain
augroup gzip
  autocmd BufReadPost,FileReadPost    *.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost    *.gz set nobin
  autocmd BufWritePost,FileWritePost  *.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost  *.gz !gzip <afile>:r
  autocmd FileAppendPre               *.gz !gunzip <afile>
  autocmd FileAppendPre               *.gz !mv <afile>:r <afile>
  autocmd FileAppendPost              *.gz !mv <afile> <afile>:r
  autocmd FileAppendPost              *.gz !gzip <afile>:r
augroup end

augroup spelling
  autocmd BufEnter *.{md,markdown} set spell
augroup end
" }}}
" COLORSCHEMES & syntax {{{
color molokai
highlight SpecialKey ctermbg=Yellow guibg=Yellow
syntax on
" }}}
" FUNCTIONS {{{

" Highlight lines longer than 80 characters as dark-red, lines longer than 90
" characters as a brighter red. Off by default.
function! HighlightLongLines()
    if exists('b:highlight_long_lines') && b:highlight_long_lines == 1
        let b:highlight_long_lines = 0
        highlight OverLength NONE
        highlight SortaOverLength NONE
    else
        let b:highlight_long_lines = 1
        highlight OverLength ctermbg=88 guibg=#990000
        highlight SortaOverLength ctermbg=52 guibg=#330000
        match SortaOverLength /\m\%>80v.\%<92v/
        2match OverLength /\m\%>90v.\%<140v/
    endif
endfunction

" EOFUNCTIONS }}}
" LEADERS {{{

" , makes my pinky hurt a lot less than \
let mapleader = ","

" show long warnings
nnoremap <silent> <leader>ll :call HighlightLongLines()<CR>

"map <C-I> :pyf $HOME/scripts/clang-format.py<CR>
"imap <C-I> <ESC>:pyf $HOME/scripts/clang-format.py<CR>i
nmap <leader>sn :Simplenote -l<CR>
nmap <leader>p :set paste<CR>
nmap <leader>P :set nopaste<CR>


nmap <leader>f :set nofoldenable<CR>

" trim trailing whitespace
nmap <leader>w :%s/\s\+$//g<CR>

" a bit meta, but I do this often enough

" pop buffer into new tab
nmap <leader>j :tabnew %<cr>gT :q<CR>gt

" CtrlP
nmap <leader>cp :CtrlPBuffer<CR>

" regen tags
nmap <leader>z :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

" tab convenience
nmap <leader>n :tabnext<cr>
nmap <leader>N :tabprev<cr>

" stupid rot13 tricks
nmap <leader>r ggg?G

" title-ize the current visual selection
vmap ,u :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

" C-U to search visual selection
vmap <silent> * :<C-U>let old_reg=@"<cr>
                  \gvy/<C-R><C-R>=substitute(
                  \escape(@", '\\/.*$^~[]'), "\n$", "", "")<CR><CR>
                  \:let @"=old_reg<cr>
vmap <silent> # :<C-U>let old_reg=@"<cr>
                  \gvy?<C-R><C-R>=substitute(
                  \escape(@", '\\/.*$^~[]'), "\n$", "", "")<CR><CR>
                  \:let @"=old_reg<cr> 

" visual line/block last edit
nmap <leader>v '[v']
nmap <leader>V '[V']

" liquid syntax seems to bog down in certain circumstances, so I'll just
" markdown by default
nmap <leader>q :set syntax=liquid<CR>

" clear search highlights
nmap <silent><leader>/ :nohls<CR>

" toggle line numbering mechanisms
nmap <silent><leader># :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

" if you find yourself needing a 256 color table, press ,color
nmap <silent><leader>color :XtermColorTable<CR>

" EOLEADERS }}}
" MAPPINGS {{{

" g/ will search for visually highlighted text, with spec chars auto-escaped
vmap <silent> g/ y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" use f7 to toggle spell check
nmap <silent> <F7> :setlocal invspell<CR>

" make j/k work better with wrapped lines
nmap j gj
nmap k gk

" make Y work like D to yank till line end
nnoremap Y y$
xnoremap Y y$

" reaching for escape is dumb; make jk equivalent to escape in insert mode,
" provided I type it quickly enough
inoremap jk <Esc>
set timeoutlen=250
set ttimeoutlen=100
set tags=tags;/

" EOMAPPINGS }}}
" PLUGINS {{{
filetype plugin indent on
" EOPLUGINS }}}
" TIPS & CRAP I FORGET ALWAYS {{{
" - ^Wo => zoom into/out of window
" ^A inrements number, ^X decrements number
" ^N/^P for autocompletion
" # is * in reverse
" ^F/^B is screenful move
" H, M, and L will control cursor position in pane
" ( and ) switch between sentences
" ^/0 and $ for line control
" w/b is word shift
" dfx -> dtx retains char x
"
" EOTIPS }}}
" PLATFORM SPECIFIC SUFFIX {{{
if has("win32") || has("win64")
  nmap <leader>M :simalt ~X<CR>
  set bdir=$HOME/tmp/vimbu
  set spellfile=$HOME/.vimspellinglist.add
  set dir=$HOME/tmp/vimsw
  set undodir=$HOME/tmp/vimun
  nmap <leader>e :e $HOME/_vimrc<CR>
  nmap <leader>s :source $HOME/_vimrc<CR>
else
  set bdir=~/tmp/vimbu,/tmp
  set spellfile=~/.vimspellinglist.add
  set dir=~/tmp/vimsw,/tmp
  set undodir=~/tmp/vimun,/tmp
  nmap <leader>e :e $HOME/.vimrc<CR>
  nmap <leader>s :source $HOME/.vimrc<CR>
endif
" }}} 
" SECRETS {{{
if filereadable(expand("$HOME/.vimrc.secrets"))
  source $HOME/.vimrc.secrets
endif
" }}}
