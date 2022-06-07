" plugins {{{1
source ~/.config/nvim/plug.vim

let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', '.root']


" colorscheme {{{1
source ~/.config/nvim/theme.vim


" latex {{{1
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" line numbers {{{1
set nu rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" general settings {{{1
set clipboard+=unnamedplus
set termguicolors
set ruler
set hlsearch
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set wrap linebreak nolist
set undofile
set wildmode=longest,list,full
set wildmenu
set colorcolumn=80



" Coc configs {{{1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>": "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>": "\<S-Tab>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
set statusline^=%{coc#status()}
" %{get(b:,'coc_current_function','')}
nmap <M-n> <Plug>(coc-diagnostic-next)
nmap <M-p> <Plug>(coc-diagnostic-prev)
" nmap <space>f <Plug>(coc-format-selected)
nmap <space>F <Plug>(coc-format)
" nnoremap <space>f :Autoformat<CR>
nmap <space>D <Plug>(coc-declaration)
nmap <space>d <Plug>(coc-definition)
nmap <space>d <Plug>(coc-definition)
nmap <space>i <Plug>(coc-implementation)
nmap <space>u <Plug>(coc-references)
nmap <space>re <Plug>(coc-refactor)
nmap <space>rn <Plug>(coc-rename)
nmap <space>c <Plug>(coc-fix-current)

nnoremap <silent> <space>K <Cmd>call CocAction('doHover')<CR>
xnoremap <silent> <space>K <Cmd>call CocAction('doHover')<CR>
nnoremap <silent> <K> :call doHover()<CR>
xnoremap <silent> <K> :call doHover()<CR>


" ripgrep {{{1
function! RgPreview(args, extra_args)
  call fzf#vim#grep("rg --column --line-number --no-heading " .
        \ "--color=always --smart-case " . a:extra_args . " " .
        \ shellescape(a:args), 1, {'options' :
        \ fzf#vim#with_preview('right:50%').options +
        \ ['--bind', 'alt-e:execute-silent(remote_tab_open_grep {} &)']})
endfunction

function! RgPreviewHidden(args, extra_args)
  call RgPreview(a:args, '--hidden --glob "!.git/*" ' . a:extra_args)
endfunction

command! -nargs=* RgPreview call RgPreview(<q-args>, '')
command! -nargs=* RgPreviewHidden call RgPreviewHidden(<q-args>, '')
" nnoremap <leader>g RgPreviewHidden
" escape chord {{{1
inoremap jk <esc>
inoremap kj <esc>

" Leader {{{1
map <space> <leader>

" Resource init.vim {{{1
nnoremap <a-r> :source ~/.config/nvim/init.vim<CR>
tnoremap <a-r> <c-\><c-n>:source ~/.config/nvim/init.vim<CR>
" Fix default behavior {{{1
map Y y$
nnoremap U <C-r>
xnoremap p pgvy

"make . repeatable macros {{{1
xnoremap @ :<c-u>call ExecuteMacroOverVisualRange()<cr>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal!  @".nr2char(getchar())
endfunction

" repeatable macros
" When . repeats g@, repeat the last macro.
function! AtRepeat(_)
  " If no count is supplied use the one saved in s:atcount.
  " Otherwise save the new count in s:atcount, so it will be
  " applied to repeats.
  let s:atcount = v:count ? v:count : s:atcount
  " feedkeys() rather than :normal allows finishing in Insert
  " mode, should the macro do that. @@ is remapped, so 'opfunc'
  " will be correct, even if the macro changes it.
  call feedkeys(s:atcount.'@@')
endfunction

function! AtSetRepeat(_)
  set opfunc=AtRepeat
endfunction

" Called by g@ being invoked directly for the first time. Sets
" 'opfunc' ready for repeats with . by calling AtSetRepeat().
function! AtInit()
  " Make sure setting 'opfunc' happens here, after initial playback
  " of the macro recording, in case 'opfunc' is set there.
  set opfunc=AtSetRepeat
  return 'g@l'
endfunction

" Enable calling a function within the mapping for @
nnoremap <expr> <plug>@init AtInit()
" A macro could, albeit unusually, end in Insert mode.
inoremap <expr> <plug>@init "\<c-o>".AtInit()
xnoremap <expr> <plug>@init AtInit()

function! AtReg()
  let s:atcount = v:count1
  let c = nr2char(getchar())
  return '@'.c."\<plug>@init"
endfunction

nmap <expr> @ AtReg()

function! QRepeat(_)
  call feedkeys('@'.s:qreg)
endfunction

function! QSetRepeat(_)
  set opfunc=QRepeat
endfunction

function! QStop()
  set opfunc=QSetRepeat
  return 'g@l'
endfunction

nnoremap <expr> <plug>qstop QStop()
inoremap <expr> <plug>qstop "\<c-o>".QStop()

let s:qrec = 0
function! QStart()
  if s:qrec == 1
    let s:qrec = 0
    return "q\<plug>qstop"
  endif
  let s:qreg = nr2char(getchar())
  if s:qreg =~# '[0-9a-zA-Z"]'
    let s:qrec = 1
  endif
  return 'q'.s:qreg
endfunction

nmap <expr> q QStart()

" Movement behavior {{{1
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

" Window movements {{{1
" Files with preview
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 15
  let width = float2nr(&columns - (&columns * 2 / 10))
  let row = float2nr((&lines - height) /2)
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ winblend=0
        \ pumblend=0
        \ norelativenumber
        \ signcolumn=no
endfunction


let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! MapWinCmd(key, command, ...)
  if a:0 && a:1
    let suffix = ""
  else
    let suffix = "<cr>"
  endif

  "silent?
  execute "nnoremap <space>h".a:key." :<c-u>aboveleft vnew <bar>".
        \ a:command.suffix
  execute "nnoremap <space>j".a:key." :<c-u>belowright new <bar>".
        \ a:command.suffix
  execute "nnoremap <space>k".a:key." :<c-u>aboveleft new <bar>".
        \ a:command.suffix
  execute "nnoremap <space>l".a:key." :<c-u>belowright vnew <bar>".
        \ a:command.suffix
  execute "nnoremap <space>;".a:key." :<c-u>call FloatingFZF()<cr>:".
        \ a:command.suffix
  execute "nnoremap <space>,".a:key." :<c-u>tabnew <bar>".
        \ a:command.suffix
  execute "nnoremap <space>.".a:key." :<c-u>".
        \ a:command.suffix
  execute "nnoremap <space>H".a:key." :<c-u>topleft vnew <bar>".
        \ a:command.suffix
  execute "nnoremap <space>J".a:key." :<c-u>botright new <bar>".
        \ a:command.suffix
  execute "nnoremap <space>K".a:key." :<c-u>topleft new <bar>".
        \ a:command.suffix
  execute "nnoremap <space>L".a:key." :<c-u>botright vnew <bar>".
        \ a:command.suffix
endfunction

call MapWinCmd("t", "terminal")

" edit/arbitrary command in new window and scratch
call MapWinCmd("e", " e ", 1)
call MapWinCmd("w", "enew <bar> setlocal bufhidden=hide nobuflisted " .
      \ "buftype=nofile")
call MapWinCmd("f", "Files")
call MapWinCmd("b", "Buffers")
call MapWinCmd("r", "RgPreview ", 1)
call MapWinCmd("R", "RgPreviewHidden ", 1)

" moving between windows
nnoremap <c-h> <c-\><c-n><c-w>h
nnoremap <c-j> <c-\><c-n><c-w>j
nnoremap <c-k> <c-\><c-n><c-w>k
nnoremap <c-l> <c-\><c-n><c-w>l

xnoremap <c-h> <c-\><c-n><c-w>h
xnoremap <c-j> <c-\><c-n><c-w>j
xnoremap <c-k> <c-\><c-n><c-w>k
xnoremap <c-l> <c-\><c-n><c-w>l

inoremap <c-h> <c-\><c-n><c-w>h
inoremap <c-j> <c-\><c-n><c-w>j
inoremap <c-k> <c-\><c-n><c-w>k
inoremap <c-l> <c-\><c-n><c-w>l

tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

nnoremap <a-h> <c-\><c-n><c-w>h
nnoremap <a-j> <c-\><c-n><c-w>j
nnoremap <a-k> <c-\><c-n><c-w>k
nnoremap <a-l> <c-\><c-n><c-w>l

xnoremap <a-h> <c-\><c-n><c-w>h
xnoremap <a-j> <c-\><c-n><c-w>j
xnoremap <a-k> <c-\><c-n><c-w>k
xnoremap <a-l> <c-\><c-n><c-w>l

inoremap <a-h> <c-\><c-n><c-w>h
inoremap <a-j> <c-\><c-n><c-w>j
inoremap <a-k> <c-\><c-n><c-w>k
inoremap <a-l> <c-\><c-n><c-w>l

tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l

" From neev
" Window remapping
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W>>
noremap <right> 3<C-W><
nnoremap <M-=> <C-w>=
nnoremap <M--> <C-w>_
nnoremap <M-\> <C-w><bar>

" Window moving
nnoremap <M-H> <C-w>H
nnoremap <M-J> <C-w>J
nnoremap <M-K> <C-w>K
nnoremap <M-L> <C-w>L



" hard escape {{{1
tnoremap <c-space> <c-\><c-n>

"fix spelling mistake {{{1
inoremap <c-f> <c-g>u<Esc>[s1z=`]a<c-g>u

function! FixSpellingMistake() abort
  let orig_spell_pos = getcurpos()
  normal! [s1z=
  call setpos('.', orig_spell_pos)
endfunction

nnoremap <c-f> <Cmd>call FixSpellingMistake()<cr>

"}}}
" vim: set fdm=marker:
