function! myspacevim#before() abort
    call SpaceVim#custom#SPC('nore', ['f', 'T'], 'Tagbar', 'show Tagbar', 1)
    call SpaceVim#custom#SPC('nore', ['p', 'T'], 'Tagbar', 'show Tagbar', 1)
    " macvim 在命令模式中，输入法自动会被禁用
    set noimd
    "mac paste
    set clipboard=unnamed
  endfunction
