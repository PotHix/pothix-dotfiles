" ****************************************************
" Some configurations with let
" ****************************************************
let mapleader = ","

" ****************************************************
" Setting statusline
" ****************************************************
" Fugitive.vim statusline to show current branch
set statusline+=%<%f\ %h%m%r%{fugitive#statusline()}%=[%{&ft}]%-14.([%l/%L],%c%V%)\ %P

" Syntastic statusline config to show syntax errors on saving
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*

" ****************************************************
" Search configurations
" ****************************************************
set is                              " IncrementedSearch
set hls                             " HighLightedSearch
set ic                              " IgnoreCase
set scs                             " SmartCaSe


" ****************************************************
" My set configurations
" ****************************************************
set ai                                          " AutoIndent
set bs=2                                        " Backspace over everything in insert mode
set cursorline                                  " Setting a line over cursor
set copyindent                                  " Copy previous indent on the current line
set encoding=utf-8                              " Default encoding is utf8
set expandtab                                   " Default encoding is utf8
set hidden					" Don't close buffers, just hidden them
set laststatus=2                                " Always show status line.
set list                                        " Configuration to use definitions below
set listchars=tab:\ \ ,extends:>,precedes:<     " Special chars to show tabs, eol and bol
set nu                                          " Line numbers on
set sw=2                                        " ShiftWidth: Used on autoindent
set timeout timeoutlen=1000 ttimeoutlen=100     " Removing esc timeout
set wildmenu                                    " Enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=list:longest                       " Make cmdline tab completion similar to bash
set wildignore+=*.o,*~,*.swp,*.pyc,*.pyo,*.gif  " Stuff to ignore when tab completing
set wildignore+=*.dll,*.obj,*.bak,*.jpg,*.png   " Stuff to ignore when tab completing


" ****************************************************
" Removing some default confs
" ****************************************************
set nocompatible                    " We're running Vim, not Vi!
set nowrap                          " Line wrapping off
set novisualbell                    " No blinking .
set noerrorbells                    " No noise.
set notitle                         " Removing 'Thanks for flying Vim' :)
set nofoldenable                    " I don't want it folding by default
