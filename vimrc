"Basic config
    syntax on
    
    set noerrorbells
    set tabstop=4 softtabstop=4
    set shiftwidth=4
    set expandtab
    set smartindent
    set nu
    set relativenumber
    set nowrap
    set smartcase
    set noswapfile
    set nobackup
    set undodir=~/.vim/undodir
    set incsearch
    set mouse=a
    set colorcolumn=80
    highlight ColorColumn ctermbg=0 guibg=lightgray

"Plugins
    call plug#begin('~/.vim/plugged')
    
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-fugitive'
    Plug 'turbio/bracey.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    call plug#end()

"Color scheme
    colorscheme gruvbox
    set background=dark
    
    if executable('rg')
        let g:rg_device_root='true'
    endif

"Remapping navigation
    let mapleader=" "
    noremap j h
    noremap k j
    noremap l k
    noremap ñ l

"Vim Airline config
    "Display all the buffers when there is only one tab opened
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme='powerlineish'
