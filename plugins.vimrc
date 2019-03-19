" Packages
" 包管理
"
" vim-go
let g:go_list_type = 'quickfix'
let g:go_fmt_command = "goimports"
let g:go_test_timeout = '60s'
let g:go_textobj_include_function_doc = 1
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "camelcase"
let g:go_highlight_types = 1
let g:go_highlight_fileds = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

augroup go
    autocmd!
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nmap <leader>t <Plug>(go-test)
    autocmd FileType go nmap <leader>r <Plug>(go-run)
    autocmd FileType go nmap <leader>d <Plug>(go-doc)
    autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <leader>i <Plug>(go-info)
    autocmd FileType go nmap <leader>l <Plug>(go-metalinter)
    autocmd FileType go nmap <leader>v <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader>s <Plug>(go-def-split)
    autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd FileType go command! -bang AS call go#alternate#Switch(<bang>0,'split')
    autocmd FileType go command! -bang AT call go#alternate#Switch(<bang>0,'tabe')
augroup END

fun! s:build_go_files()
    let l:file=expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0,1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfun


"
