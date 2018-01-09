if exists("g:loaded_uncommented")
  finish
endif
let g:loaded_uncommented = 1

function! s:Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! s:GetCommentString() 
    let l:index = match(&commentstring, '%s')
    if l:index == -1
	return ''
    endif
    return s:Strip(strcharpart(&commentstring, 0, l:index))
endfunction

function! s:GoToUncommented(direction)
    let l:commentbeg = s:GetCommentString()
    if strlen(l:commentbeg) == 0
        return
    endif

    call search('\v^(\s*' . l:commentbeg . ')@!', 'Wz' . a:direction)
endfunction

nnoremap <script> <unique> <silent> <Plug>(PrevUncommented) :call <SID>GoToUncommented('b')<CR>
nnoremap <script> <unique> <silent> <Plug>(NextUncommented) :call <SID>GoToUncommented('')<CR>

" TODO:
" - ignore blank lines
" - allow define custom comment strings for languages with multiple comment strings
