" SuperTab setting
" uses omni if enabled
let g:SuperTabDefaultCompletionType = "context"

nnoremap <leader>gl :GoLint<CR>
inoremap <leader>gl <ESC>:GoLint<CR>
vnoremap <leader>gl <ESC>:GoLint<CR>
nnoremap <leader>gv :GoVet<CR>
inoremap <leader>gv <ESC>:GoVet<CR>
vnoremap <leader>gv <ESC>:GoVet<CR>

" Tagbar support for go."
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"vim-go settings
" format with goimports instead of gofmt

let g:go_fmt_command = "goimports"
