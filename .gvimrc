set nocompatible


so ~/.vim/plugins.vim

syntax enable
syntax on
set encoding=utf-8
set backspace=indent,eol,start
let mapleader = ','

set complete=.,w,b,u 
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set noswapfile
set ignorecase  "ignore Number Case
set nobackup
set textwidth=120  "setting max text width
set autowriteall   "automatically write the file when switch buffer
set expandtab autoindent
"set mousehide "hide mouse when typing
"set mouse -=a
set clipboard=unnamed "mac下的剪切板
"----------------View-------------"
set t_CO=256
set background=dark
colorscheme hybrid_material
"colors dracula 

set guifont=Fira\ Code:h17
set macligatures

"let g:enable_bold_font = 1
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=e "tab

set number
set linespace=15 "macvim line-height
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
"n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
"i  Insert mode map. Defined using ':imap' or ':inoremap'.
"v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
"x  Visual mode map. Defined using ':xmap' or ':xnoremap'.
"s  Select mode map. Defined using ':smap' or ':snoremap'.
"c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
"o  Operator pending mode map. Defined using ':omap' or ':onoremap'.

map <Leader>ev :tabedit ~/.gvimrc<cr>

nmap <Leader>es :e  ~/.vim/snippets/
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>
nmap <Leader><space> :nohlsearch<cr>

if has("gui_macvim") && has("gui_running")
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  " Map Command-# to switch tabs
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
else
  " Map Control-# to switch tabs
  map  <C-1> 1gt
  imap <C-1> <Esc>1gt
  map  <C-2> 2gt
  imap <C-2> <Esc>2gt
  map  <C-3> 3gt
  imap <C-3> <Esc>3gt
  map  <C-4> 4gt
  imap <C-4> <Esc>4gt
  map  <C-5> 5gt
  imap <C-5> <Esc>5gt
  map  <C-6> 6gt
  imap <C-6> <Esc>6gt
  map  <C-7> 7gt
  imap <C-7> <Esc>7gt
  map  <C-8> 8gt
  imap <C-8> <Esc>8gt
  map  <C-9> 9gt
  imap <C-9> <Esc>9gt
endif

" make NERDTree
nmap <Leader>d :NERDTreeToggle<cr>

" CtrlP
nmap <D-p> :CtrlP<cr>
"nmap <D-r> :CtrlPBufTag<cr>
nmap <D-e> :CtrlPMRUFiles<cr>
" ctags
nmap <Leader>f :tag<space>
nmap <D-[> <C-t>
nmap <D-]> g<C-]>
"Ag
nmap <Leader>a :Ag<space>

"php-cs-fixer
nmap <silent><Leader>lfd :call PhpCsFixerFixDirectory()<CR>
nmap <silent><Leader>lf :call PhpCsFixerFixFile()<CR>

"disabled up down left right
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>

"tagBar
"nmap <D-9> :TagbarToggle<CR>
nmap <Leader>t :TagbarOpenAutoClose<CR>

"paste form system
vmap <Leader>y "+y
vmap <Leader>p "+p

"disable mouse
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

"jsonFormat
map <Leader>jf <Esc>:%!python -m json.tool<CR>

"------------Plugins------------"

"
"/php
"
" setting phpdoc highlight
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

"
"/
"/ CtrlP
"/

let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
let g:ctrlp_mruf_relative = 1 

"/
"/ NERDTree
"/
let NERDTreeHijackNetrw = 0

"/
"/ grepacmsanders/snipmate.vime
"/
set grepprg=ag
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:grep_cmd_opts = '--line-numbers --noheading'

"/
"/  php-cs-fixer
"/

"let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
"let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
let g:php_cs_fixer_config_file = '.php_cs' " options: --config
" End of php-cs-fixer version 2 config params
"
let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.


"/
"/ macvim 在命令模式中，输入法自动会被禁用
"/
set noimd
set imi=2
set ims=2

"/
"/ vim-php-namespace
"/
let g:php_namespace_sort_after_insert = 1

"/
"/ tagBar
"/


"/
"/ editorconfig
"/
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'  "The file path to the EditorConfig core executable.
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
"let g:EditorConfig_max_line_indicator = "fill"
let g:EditorConfig_max_line_indicator = "line"

"auto source .vimrc file on save
augroup autosourcing
"autocmd BufWritePost .vimrc source %
augroup end

"auto fix php psr2
"augroup autoFixPsr
"    autocmd BufWritePost *.php call PhpCsFixerFixFile()
"augroup end
"autocmd BufEnter * set mouse -=a

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
"autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
"autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>

"Note and Tips
" -Press 'zz' to instanstly center the line where the cursor is located.

if has("gui_macvim")
    macmenu &File.Print key=<nop>
endif
