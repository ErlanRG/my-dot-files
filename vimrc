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
"Some of these plugins won't work on RPi ARMv7 architectures
    call plug#begin('~/.vim/plugged')
    
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-fugitive'
    Plug 'turbio/bracey.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'jiangmiao/auto-pairs'
    Plug 'mattn/emmet-vim'
    Plug 'Valloric/YouCompleteMe'
    Plug 'nathanaelkane/vim-indent-guides'

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

    nnoremap <leader>j :wincmd h<CR>
    nnoremap <leader>k :wincmd j<CR>
    nnoremap <leader>l :wincmd k<CR>
    nnoremap <leader>ñ :wincmd l<CR>
    nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

"Vim Airline config
    "Display all the buffers when there is only one tab opened
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme='powerlineish'

"Indent Guides settings
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size=1

"YouCompleteMe
    set completeopt-=preview
