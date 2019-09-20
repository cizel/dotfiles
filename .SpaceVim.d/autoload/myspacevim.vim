function! myspacevim#before() abort
  call SpaceVim#custom#SPC('nore', ['f', 'T'], 'Tagbar', 'show Tagbar', 1)
  call SpaceVim#custom#SPC('nore', ['p', 'T'], 'Tagbar', 'show Tagbar', 1)
  " macvim 在命令模式中，输入法自动会被禁用
  set noimd
  "mac paste
  set clipboard=unnamed
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn|rvm|node_modules)$',
        \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|DS_Store)$',
        \ }
  let g:ctrlp_match_window = 'buttom, order:ttb,min:1,max:10,results:10'
  let g:ctrlp_working_path_mode=0
  let g:ctrlp_match_window_reversed=0
  let g:ctrlp_follow_symlinks=1
  let g:ctrlp_mruf_relative = 0
  "let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']
endfunction
