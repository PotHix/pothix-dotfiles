" Useful shortcuts
cab W w | cab Q q | cab Wq wq | cab wQ wq | cab WQ wq
cab Wqa wqa | cab Wa wa | cab WQa wqa | cab WQA wqa | cab w] w | cab w[ w

" Saving when a forgot to open file as root
cmap w!! w !sudo tee % >/dev/null

" Comment lines
map <leader># :s/^/#/<CR>:nohls<CR>

" Remove trailing spaces
nmap <leader>rt :%s/\s\+$//<CR>

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

" Adding lines on normal mode easily
" nnoremap <C-k> O<ESC>  " *** not needed because of colemak
" nnoremap <C-j> o<ESC>  " *** not needed because of colemak

" Some things on the middle of the screen
nmap g* g*zz
nmap g# g#zz
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz

" Easy home and end
map H ^
" map L $                " *** not needed because of colemak

"make Y consistent with C and D
nnoremap Y y$

"Some shortcuts to ESC
" inoremap jj <ESC>      " *** not needed because of colemak
" inoremap kj <ESC>      " *** not needed because of colemak


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colemak
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" home row
noremap n j
noremap e k
noremap i l

" l is the new i
noremap l i
noremap L I

" and k became n
noremap k n
noremap K N

" the same for splits
noremap <C-w>n <C-w>j
noremap <C-w>N <C-w>J
noremap <C-w>e <C-w>k
noremap <C-w>E <C-w>K
noremap <C-w>i <C-w>l
noremap <C-w>I <C-w>L

" Easy end
noremap I $

" Adding lines on normal mode easily
nnoremap <C-e> O<ESC>
nnoremap <C-n> o<ESC>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype changings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>fr :set filetype=ruby<CR>
nmap <leader>fp :set filetype=python<CR>
nmap <leader>fj :set filetype=javascript<CR>
nmap <leader>fy :set filetype=yaml<CR>
nmap <leader>fm :set filetype=markdown<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maps for plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Open Spec on a vertical Split using RailsVim
nnoremap <F4> :AV<CR>

" Different mappings for Rails.vim
autocmd User Rails Rnavcommand consumer app/consumers -default=model()
autocmd User Rails Rnavcommand factory db/factories -default=factories
autocmd User Rails Rnavcommand seeds db/ -default=seeds

nnoremap <space>/ :Unite grep:.<cr>

let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>

noremap <space>s :Unite -quick-match buffer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other shortcuts using F1-F12 keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enabling spelling to Brazillian Portuguese
nmap <F8> :setlocal spell spelllang=pt<CR>
nmap <F9> :setlocal spell spelllang=en<CR>
nmap <F10> :setlocal nospell<CR>
