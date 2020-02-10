function! myspacevim#before() abort
  call SpaceVim#custom#SPC('nore', ['f', 'T'], 'Tagbar', 'show Tagbar', 1)
  call SpaceVim#custom#SPC('nore', ['p', 'T'], 'Tagbar', 'show Tagbar', 1)
  call SpaceVim#custom#SPC('nore', ['p', 't'], 'NERDTreeFind', 'Find file location in tree', 1)
  call SpaceVim#custom#SPC('nore', ['/'], 'Ag', 'Find file in path', 1)

	"--------------- basic setting ---------------"
  " macvim 在命令模式中，输入法自动会被禁用
  set noimd
  "mac paste
  set clipboard=unnamed

	" do not use mouse
	set mouse -=a

	"automatically write the file when switch buffer
	set autowriteall

	" enable paste
	set paste

	" set no bell
	set noerrorbells visualbell t_vb=

	" backsapce behavior
	set backspace=indent,eol,start

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

    " auto wrap the line
    set wrap
    set linebreak
    set wrapmargin=2

    "hide mouse when typing
    set mousehide

	"----------------  Mappings ---------------"
	"n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
	"i  Insert mode map. Defined using ':imap' or ':inoremap'.
	"v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
	"x  Visual mode map. Defined using ':xmap' or ':xnoremap'.
	"s  Select mode map. Defined using ':smap' or ':snoremap'.
	"c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
	"o  Operator pending mode map. Defined using ':omap' or ':onoremap'.

	"nmap <Leader>/ :Ag<space>
	nmap <D-[> <C-t>
	nmap gd g<C-]>

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

	"----------------  Plugins ---------------"
	
	" ctrlp
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn|rvm|node_modules)$',
        \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|DS_Store)$',
        \ }
  let g:ctrlp_match_window = 'buttom, order:ttb,min:1,max:10,results:10'
  let g:ctrlp_working_path_mode=0
  let g:ctrlp_match_window_reversed=0
  let g:ctrlp_follow_symlinks=1
  let g:ctrlp_mruf_relative = 0


endfunction
