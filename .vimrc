set nocompatible

so ~/.vim/plugins.vim

syntax enable
set backspace=indent,eol,start
let mapleader = ','
set number
set linespace=16 "macvim line-height

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set noswapfile
set paste
set clipboard=unnamed "mac下的剪切板

"----------------View-------------"
colorscheme atom-dark
set t_CO=256
set background=dark
"set background=dark
"colorscheme hybrid_material
set guifont=Fira\ Code:h18

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set noerrorbells visualbell t_vb=


"----------------Search-------------"
set hlsearch
set incsearch


"----------------Split Managnment-------------"
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>
"----------------Mappings-------------"
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader><space> :nohlsearch<cr>
" make NERDTree
nmap <Leader>1 :NERDTreeToggle<cr>
"-------------Auto_Commands-----------"
"auto source .vimrc file on save
augroup autosourcing
"autocmd BufWritePost .vimrc source %
augroup end

