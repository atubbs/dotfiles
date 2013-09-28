" vim: set foldmethod=marker foldlevel=0:
" VUNDLE {{{
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Don't forget to :VundleInstall to bootstrap environment!
Bundle 'tomasr/molokai'
Bundle 'tpope/vim-fugitive'
Bundle 'ervandew/supertab'
Bundle 'bling/vim-airline'

" }}}
" SETTINGS {{{

let g:airline_powerline_fonts = 1

" make quickfix use existing buffer if present, otherwise spawn a new tab,
" rather than do stupid shit
:set switchbuf+=usetab,newtab

" make sure ({}) doesn't error in C++11
let c_no_curly_error=1

"let g:SuperTabDefaultCompletionType = "<c-x><c-]>"
"let g:SuperTabDefaultCompletionType = "<c-n>"
"let g:SuperTabContextDefaultCompletionType = "<c-n>"

set autochdir
set backspace=indent,eol,start
set bdir=~/tmp/vimbu,/tmp
set bk
set bkc=yes " needed in order to preserve application assignment to file in OS X
set completeopt=longest,menu,preview
set complete-=i " don't scan included files (slow)
set diffopt=filler,vertical,iwhite,foldcolumn:2
set dir=~/tmp/vimsw,/tmp
set display=lastline
set encoding=utf-8
set expandtab
set fileformats=unix,mac,dos
set foldcolumn=1
set foldmethod=manual
set foldminlines=0
set nofoldenable
set formatlistpat=^\\s*\\(\\d\\+\\\|\\*\\\|-\\\|∙\\\|•\\\|∘\\\|·\\)[]:.)}\\t\ ]\\s*
set formatoptions=croqnl12
set grepprg=grep\ -nH\ $* " my grep supports -H, so I've set it, since options.txt told me to
set guifont=Bitstream\ Vera\ Sans\ Mono\ 12 " foo
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
set spellfile=~/.vimspellinglist.add
set spelllang=en



set statusline=
set statusline +=\ %n\ %*            "buffer number
set statusline +=%{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\ \"}%* " encoding
set statusline +=%{&ff}%*            "file format
"set statusline +=\ %y%*              "file type
set statusline +=\ %<%F%*            "full path
set statusline +=%m%*                "modified flag
set statusline +=%=%5l%*             "current line
set statusline +=/%L%*               "total lines
set statusline +=%4v\ %*             "virtual column number
set statusline +=0x%04B\ %*          "character under cursor
set sts=2
set sw=2
set title
set ttyfast
set ttymouse=xterm2
set tw=75 " try to fit in 80 characters
set undodir=~/tmp/vimun,/tmp
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
  autocmd BufEnter *.{markdown} set spell
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

nmap <leader>p :set paste<CR>
nmap <leader>P :set nopaste<CR>

nmap <leader>f :set nofoldenable<CR>

" trim trailing whitespace
nmap <leader>w :%s/\s\+$//g<CR>

" a bit meta, but I do this often enough
nmap <leader>e :e ~/.vimrc<CR>
nmap <leader>s :source ~/.vimrc<CR>

" pop buffer into new tab
nmap <leader>j :tabnew %<cr>gT :q<CR>gt

" regen tags
nmap <leader>z :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

" tab convenience
nmap <leader>n :tabnext<cr>
nmap <leader>N :tabprev<cr>

" stupid rot13 tricks
nmap <leader>r ggg?G

" title-ize the current visual selection
vmap ,u :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

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

" LEADERS {{{
" LEADERS {{{

" , makes my pinky hurt a lot less than \
let mapleader = ","

" show long warnings
nnoremap <silent> <leader>ll :call HighlightLongLines()<CR>

" trim trailing whitespace
nmap <leader>c :%s/\s\+$//g<CR>

" a bit meta, but I do this often enough
nmap <leader>e :e ~/.vimrc<CR>
nmap <leader>s :source ~/.vimrc<CR>

" pop buffer into new tab
nmap <leader>j :tabnew %<cr>gT :q<CR>gt

" tab convenience
nmap <leader>n :tabnext<cr>
nmap <leader>N :tabprev<cr>

" stupid rot13 tricks
nmap <leader>r ggg?G

" title-ize the current visual selection
vmap ,u :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

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
" LEADERS {{{

" , makes my pinky hurt a lot less than \
let mapleader = ","

" show long warnings
nnoremap <silent> <leader>ll :call HighlightLongLines()<CR>

" trim trailing whitespace
nmap <leader>c :%s/\s\+$//g<CR>

" a bit meta, but I do this often enough
nmap <leader>e :e ~/.vimrc<CR>
nmap <leader>s :source ~/.vimrc<CR>

" pop buffer into new tab
nmap <leader>j :tabnew %<cr>gT :q<CR>gt

" tab convenience
nmap <leader>n :tabnext<cr>
nmap <leader>N :tabprev<cr>

" stupid rot13 tricks
nmap <leader>r ggg?G

" title-ize the current visual selection
vmap ,u :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

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
" LEADERS {{{

" , makes my pinky hurt a lot less than \
let mapleader = ","

" show long warnings
nnoremap <silent> <leader>ll :call HighlightLongLines()<CR>

" trim trailing whitespace
nmap <leader>c :%s/\s\+$//g<CR>

" a bit meta, but I do this often enough
nmap <leader>e :e ~/.vimrc<CR>
nmap <leader>s :source ~/.vimrc<CR>

" pop buffer into new tab
nmap <leader>j :tabnew %<cr>gT :q<CR>gt

" tab convenience
nmap <leader>n :tabnext<cr>
nmap <leader>N :tabprev<cr>

" stupid rot13 tricks
nmap <leader>r ggg?G

" title-ize the current visual selection
vmap ,u :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

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
" LEADERS {{{

" , makes my pinky hurt a lot less than \
let mapleader = ","

" show long warnings
nnoremap <silent> <leader>ll :call HighlightLongLines()<CR>

" trim trailing whitespace
nmap <leader>c :%s/\s\+$//g<CR>

" a bit meta, but I do this often enough
nmap <leader>e :e ~/.vimrc<CR>
nmap <leader>s :source ~/.vimrc<CR>

" pop buffer into new tab
nmap <leader>j :tabnew %<cr>gT :q<CR>gt

" tab convenience
nmap <leader>n :tabnext<cr>
nmap <leader>N :tabprev<cr>

" stupid rot13 tricks
nmap <leader>r ggg?G

" title-ize the current visual selection
vmap ,u :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

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

" , makes my pinky hurt a lot less than \
let mapleader = ","

" show long warnings
nnoremap <silent> <leader>ll :call HighlightLongLines()<CR>

" trim trailing whitespace
nmap <leader>c :%s/\s\+$//g<CR>

" a bit meta, but I do this often enough
nmap <leader>e :e ~/.vimrc<CR>
nmap <leader>s :source ~/.vimrc<CR>

" pop buffer into new tab
nmap <leader>j :tabnew %<cr>gT :q<CR>gt

" tab convenience
nmap <leader>n :tabnext<cr>
nmap <leader>N :tabprev<cr>

" stupid rot13 tricks
nmap <leader>r ggg?G

" title-ize the current visual selection
vmap ,u :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

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
" use f7 to toggle spell check
nmap <silent> <F7> :setlocal invspell<CR>

" make Y work like D to yank till line end
nnoremap Y y$
xnoremap Y y$

" training wheels
"inoremap  <Up> <nop>
"inoremap! <Up> <nop>
"inoremap  <Down> <nop>
"inoremap! <Down> <nop>
"inoremap  <Left> <nop>
"inoremap! <Left> <nop>
"inoremap  <Right> <nop>
"inoremap! <Right> <nop>

" reaching for escape is dumb; make jk equivalent to escape in insert mode,
" provided I type it quickly enough
inoremap jk <Esc>
set timeoutlen=250
set ttimeoutlen=100
set tags=tags;/

" EOMAPPINGS }}}
" PLUGINS {{{
filetype plugin indent on

highlight ShowMarksHLl ctermfg=161 ctermbg=235
highlight ShowMarksHLu ctermfg=81 ctermbg=235
highlight ShowMarksHLo ctermfg=135 ctermbg=235
highlight ShowMarksHLm ctermfg=118 ctermbg=235

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
