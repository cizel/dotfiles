" load plugins
source ~/.vim/plugins.vim

"--------------- basic setting ---------------"

" diable old vi
set nocompatible

" show synatx highlight
syntax on

" show insert/command text
set showmode

" show leader key and typing words in normal mode
set showcmd

" do not use mouse
set mouse -=a

" set use utf-8 encoding
set encoding=utf-8

" enable 256 color
set t_Co=256

" auto load indent from ~/.vim/indent/*.vim
filetype indent on

"automatically write the file when switch buffer
set autowriteall

" enable paste
set paste

"mac paste
set clipboard=unnamed

" no swap file
"set noswapfile
set directory=~/.vim/swap/

" no backup file
"set nobackup
set backupdir=~/.vim/backup/

" no undofile
"set undofile
set undodir=~/.vim/undo/

" set no bell
set noerrorbells visualbell t_vb=

set history=1000

" backsapce behavior
set backspace=indent,eol,start

"set complete=.,w,b,u

"--------------- indent ----------------"

" next line auto indent
set autoindent

" tab to space width
set tabstop=4

" press `<<` or `>>` indent width
set shiftwidth=4

" set Tab auto change to space
set expandtab

" set Tab change to space width
set softtabstop=4


"--------------- appearance ---------------"

" show relative line number
set relativenumber
set number

" highlight current line
"set cursorline

" set line width
set textwidth=80

" auto wrap the line
set wrap
set linebreak
set wrapmargin=2

"hide mouse when typing
set mousehide

set background=dark

"set nofoldenable

color desert

highlight CursorLine term=bold

"--------------- search ---------------"

set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

"----------------  Mappings ---------------"
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

" fzf
nmap <Leader>bb :Buffer<cr>


"ag
nmap <Leader>/ :Ag<space>

"tagBar
nmap <Leader>t :TagbarOpenAutoClose<CR>

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

" vim go
let g:go_version_warning = 0

" macvim 在命令模式中，输入法自动会被禁用
set noimd

if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window (for an alternative on Windows, see simalt below).
    set lines=999 columns=999
    "diabled colorscheme hybrid_material

    set guifont=Fira\ Code:h18

    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=e "tab

    set linespace=15 "macvim line-height
endif

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

"Note and Tips
" -Press 'zz' to instanstly center the line where the cursor is located.
