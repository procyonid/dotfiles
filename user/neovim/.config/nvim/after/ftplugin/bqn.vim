" packer is causing this file to be loaded twice, so I'm supressing the errors
" caused by unmapping the already unmapped keys
silent! xunmap <buffer> <Space>bc
silent! nunmap <buffer> <Space>bc
silent! nunmap <buffer> <Space>bC
silent! nunmap <buffer> <Space>bf

nmap <buffer> <silent> <Esc> :noh <bar> BQNClearFile<CR>

nnoremap <buffer> <silent> <CR> :BQNEvalFile<CR>
xnoremap <buffer> <silent> <CR> :BQNEvalRange<CR>
