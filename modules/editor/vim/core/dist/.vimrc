" ****************************************************************
" USING VUNDLE FOR VIM PLUGINS
" ****************************************************************
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-ragtag'
Plugin 'vim-scripts/vimwiki'
Plugin 'kien/ctrlp.vim'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/VimRepress'
Plugin 'elixir-lang/vim-elixir'
Plugin 'wakatime/vim-wakatime'

call vundle#end()

" ****************************************************************
" COLORS AND SYNTAX
" ****************************************************************
colorscheme desert
syntax on               " Enable syntax highlighting
filetype plugin indent on

" Search Options
hi    Search ctermbg=green ctermfg=black
hi IncSearch ctermbg=black ctermfg=green


" ****************************************************************
" INCLUDES
" ****************************************************************
source ~/.vim/custom/settings.vim
source ~/.vim/custom/useful_mappings.vim


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


" ****************************************************************
" LANGUAGE SPECIFIC
" ****************************************************************
autocmd BufWritePre *.go Fmt  " Always running gofmt for Go lang.


" ****************************************************************
" TRAILING SPACE REMOVER
" ****************************************************************
autocmd BufWritePre * :%s/\s\+$//e


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


" ****************************************************************
" SPECIFIC FUNCTIONS
" ****************************************************************
"define :Lorem command to dump in a paragraph of lorem ipsum
command! -nargs=0 Lorem :normal iLorem ipsum dolor sit amet, consectetur
      \ adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
      \ magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
      \ ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
      \ irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
      \ fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non
      \ proident, sunt in culpa qui officia deserunt mollit anim id est
      \ laborum


let g:browser = 'firefox -new-tab '


" Run the current spec file with spec command
function! RunCurrentSpec(spec)
   exec '!rspec '.a:spec
endfunction
map <F7> :call RunCurrentSpec(bufname("%"))<cr>


function! HTMLFormatting()
  "set noexpandtab " Removing tabs
  set softtabstop=4 shiftwidth=4 tabstop=4
  autocmd User Rails set softtabstop=4 shiftwidth=4 tabstop=4
endfunction
