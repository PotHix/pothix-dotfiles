" ****************************************************************
" USING VUNDLE FOR VIM PLUGINS
" ****************************************************************
set nocompatible              " be iMproved, required
let mapleader = ","           " a better leader
filetype off                  " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-ragtag'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/vimwiki'
Plug 'Lokaltog/vim-easymotion'
Plug 'elixir-lang/vim-elixir'
Plug 'kien/ctrlp.vim'
Plug 'othree/html5.vim'
Plug 'wakatime/vim-wakatime'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

call plug#end()


" ****************************************************
" Configuring plugins
" ****************************************************
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_solarized_normal_green=1

let g:ale_fixers = {
\   'python': ['yapf'],
\}
let g:ale_fix_on_save = 1

let g:ctrlp_map = '<c-t>'


" ****************************************************
" COLORS AND SYNTAX
" ****************************************************
colorscheme desert
syntax on               " Enable syntax highlighting
filetype plugin indent on

" Search Options
hi    Search ctermbg=green ctermfg=black
hi IncSearch ctermbg=black ctermfg=green

" Useful shortcuts
cab W w | cab Q q | cab Wq wq | cab wQ wq | cab WQ wq
cab Wqa wqa | cab Wa wa | cab WQa wqa | cab WQA wqa | cab w] w | cab w[ w

" Saving when a forgot to open file as root
cmap w!! w !sudo tee % >/dev/null

" Comment lines
map <leader># :s/^/#/<CR>:nohls<CR>

" DOS2nix
nmap <leader>unix :%s/\r$//<CR>

" Pasting on the below line when yanked with visual mode
nmap <leader>p :put<CR>==

" Mapping <tab> to chage tabs on commands mode
nmap <tab> :tabnext<CR>

" Fixing 80 chars.
imap <C-g> <ESC>gqipA

" Make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Pasting made easy
set pastetoggle=<F11>

" Easy home and end
map H ^

"make Y consistent with C and D
nnoremap Y y$


" Enabling spelling to Brazillian Portuguese
nmap <F8> :setlocal spell spelllang=pt<CR>
nmap <F9> :setlocal spell spelllang=en<CR>
nmap <F10> :setlocal nospell<CR>


" ****************************************************
" Setting statusline
" ****************************************************
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:solarized_termcolors=16
let g:airline_solarized_normal_green=1


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


" ****************************************************************
" LANGUAGUE INDENT CONFIGURATION
" ****************************************************************
autocmd FileType make       set noexpandtab

autocmd FileType eruby      call HTMLFormatting()
autocmd FileType html       call HTMLFormatting()
autocmd FileType xhtml      call HTMLFormatting()
autocmd FileType sh         call HTMLFormatting()
autocmd FileType xml        call HTMLFormatting()

autocmd FileType go         set noexpandtab sw=8 ts=8 sts=8
autocmd FileType ruby       set expandtab sw=2 ts=2 sts=2
autocmd FileType python     set expandtab sw=4 ts=4 sts=4
autocmd FileType javascript set expandtab sw=4 ts=4 sts=4

function! HTMLFormatting()
  "set noexpandtab " Removing tabs
  set softtabstop=4 shiftwidth=4 tabstop=4
  autocmd User Rails set softtabstop=4 shiftwidth=4 tabstop=4
endfunction


" ****************************************************************
" TEMPLATES
" ****************************************************************
" HTML: When a new .html is opened, it will come with a skeleton pre-designed
au BufNewFile *.html read ~/.vim/templates/html/skeleton.html


" ****************************************************************
" USEFUL VIM CONFS
" ****************************************************************
" Store cursor position and command history
set viminfo='10,\"30,:40,%,n~/.viminfo
au BufReadPost * if line("'\"")|execute("normal `\"")|endif

" Trailing spaces remover
autocmd BufWritePre * :%s/\s\+$//e
