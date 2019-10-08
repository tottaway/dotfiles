source ~/.config/nvim/plug.vim

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"
set background=dark

set nu rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set clipboard+=unnamedplus
set termguicolors
set ruler
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set wrap linebreak nolist
set undofile
set wildmode=longest,list,full
set spell
set wildmenu

" Coc configs
inoremap <expr> <Tab> pumvisible() ? "\<C-n>": "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>": "\<S-Tab>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Remappings
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
