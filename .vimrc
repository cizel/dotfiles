" load plugins
source ~/.vim/plugins.vim

set encoding=utf-8
set backspace=indent,eol,start

set showmode
set autoindent
set complete=.,w,b,u
set tabstop=4
set shiftwidth=4
set showcmd
set softtabstop=4
set expandtab
set noswapfile
set ignorecase  "ignore Number Case
set nobackup
set autowriteall   "automatically write the file when switch buffer
set mousehide "hide mouse when typing
"set mouse -=a
set clipboard=unnamed "mac下的剪切板
set wrap
set textwidth=0
set nofoldenable
set nowrap
set wrapmargin=2
set paste

" View
set t_Co=256
set background=dark
" colorscheme hybrid_material

set guifont=Fira\ Code:h18

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=e "tab

set number
set relativenumber
set linespace=15 "macvim line-height
set noerrorbells visualbell t_vb=

"----------------Search-------------"
set hlsearch
set incsearch

"----------------Mappings-------------"
"n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
"i  Insert mode map. Defined using ':imap' or ':inoremap'.
"v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
"x  Visual mode map. Defined using ':xmap' or ':xnoremap'.
"s  Select mode map. Defined using ':smap' or ':snoremap'.
"c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
"o  Operator pending mode map. Defined using ':omap' or ':onoremap'.

" keyboard shortcuts
let mapleader="\<Space>"

nmap <leader>wj <C-W><C-J>
nmap <leader>wk <C-W><C-K>
nmap <leader>wh <C-W><C-H>
nmap <leader>wl <C-W><C-L>

nmap <silent> <leader>feR :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vim config reloaded'"<CR>

nmap <Leader>fed :tabedit ~/.vimrc<cr>
nmap <Leader>fes :e  ~/.vim/snippets/
nmap <Leader>fep :tabedit ~/.vim/plugins.vim<cr>

nmap <Leader>sc :nohlsearch<cr>

" NERDTree
nmap <Leader>pt :NERDTreeToggle<cr>

nmap <D-[> <C-t>
nmap gd g<C-]>

" CtrlP
nmap <Leader>pf :CtrlP<cr>
nmap <Leader>sj :CtrlPBufTag<cr>
nmap <Leader>pr :CtrlPMRUFiles<cr>
nmap <Leader>fr :CtrlPMRUFiles<cr>

"ag
nmap <Leader>/ :Ag<space>

"tagBar
nmap <Leader>t :TagbarOpenAutoClose<CR>

"paste form system
"vmap <Leader>y "+y
"vmap <Leader>p "+p

"disable key
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>
map <ScrollWheelUp> <nop>
map <S-ScrollWheelUp> <nop>
map <C-ScrollWheelUp> <nop>
map <ScrollWheelDown> <nop>
map <S-ScrollWheelDown> <nop>
map <C-ScrollWheelDown> <nop>
map <ScrollWheelLeft> <nop>
map <S-ScrollWheelLeft> <nop>
map <C-ScrollWheelLeft> <nop>
map <ScrollWheelRight> <nop>
map <S-ScrollWheelRigt> <nop>
map <C-ScrollWheelRigt> <nop>

" setting phpdoc highlight
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

" PHP Syntax Override
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" CtrlP
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn|rvm|node_modules)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|DS_Store)$',
    \ }
let g:ctrlp_match_window = 'buttom, order:ttb,min:1,max:10,results:10'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_reversed=0
let g:ctrlp_follow_symlinks=1
let g:ctrlp_mruf_relative = 0
let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']

" NERDTree
let NERDTreeHijackNetrw = 1
let g:NERDTreeChDirMode = 2

" grepacmsanders/snipmate.vim
set grepprg=ag
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:grep_cmd_opts = '--line-numbers --noheading'

" vim-php-namespace
let g:php_namespace_sort_after_insert = 1

" editorconfig
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'  "The file path to the EditorConfig core executable.
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_max_line_indicator = "line"

" vim root
let g:rooter_patterns = ['.git/']

" macvim 在命令模式中，输入法自动会被禁用
set noimd

if has("gui_running")
	" GUI is running or is about to start.
	" Maximize gvim window (for an alternative on Windows, see simalt below).
	set lines=999 columns=999
endif

"Note and Tips
" -Press 'zz' to instanstly center the line where the cursor is located.
