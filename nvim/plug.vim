set nocompatible
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" Declare the list of plugins.
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'niklas-8/vim-darkspace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-rooter'
Plug 'itchyny/lightline.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'honza/vim-snippets'
Plug 'rhysd/vim-clang-format'
Plug 'rhysd/vim-autoformat'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
