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

" Some things on the middle of the screen
nmap g* g*zz
nmap g# g#zz
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz

" Easy home and end
map H ^

"make Y consistent with C and D
nnoremap Y y$


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
