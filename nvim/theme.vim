let g:lightline = {}
let g:lightline.active = {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [ 'readonly', 'filename', 'modified', 'cocstatus' ] ]}
let g:lightline.component_function = {'cocstatus': 'coc#status'}
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
set background=light
set termguicolors
let g:gruvbox_constrast_dark = "hard"
colorscheme gruvbox
let g:lightline.colorscheme = 'gruvbox'
