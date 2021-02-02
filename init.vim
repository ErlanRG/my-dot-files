"Basic config
    syntax on
    
    set noerrorbells
    set tabstop=4 softtabstop=4
    set shiftwidth=4
    set expandtab
    set smartindent
    set nohlsearch
    set nonu
    set relativenumber
    set nowrap
    set smartcase
    set noswapfile
    set nobackup
    set undodir=~/.vim/undodir
    set undofile
    set incsearch
    set mouse=a
    set colorcolumn=80
    set scrolloff=8
    highlight ColorColumn ctermbg=0 guibg=lightgray

"Plugins
    call plug#begin('~/.vim/plugged')

    "Colorscheme 
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'nathanaelkane/vim-indent-guides'

    "Others
    Plug 'tpope/vim-fugitive'
    Plug 'jiangmiao/auto-pairs'
    Plug 'mbbill/undotree'

    "LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'

    call plug#end()

"Color scheme
    colorscheme gruvbox
    set background=dark

"Remapping navigation
 
    let mapleader=" "
    noremap j h
    noremap k j
    noremap l k
    noremap ; l

    "Vim window navigation
    nnoremap <leader>j :wincmd h<CR>
    nnoremap <leader>k :wincmd j<CR>
    nnoremap <leader>l :wincmd k<CR>
    nnoremap <leader>; :wincmd l<CR>
    nnoremap <leader>u :UndotreeShow<CR>
    nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
    nnoremap <silent> <leader>+ :vertical resize +5<CR>
    nnoremap <silent> <leader>- :vertical resize -5<CR>

    "Tab navigation
    nnoremap <C-k> :tabnext<CR>
    nnoremap <C-j> :tabprevious<CR>

"Vim Airline config
    "Display all the buffers when there is only one tab opened
        let g:airline_powerline_fonts=1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme='powerlineish'

"Indent Guides settings
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size=1

"Folding
    "Space to toggle folds
    nnoremap <Space> za
    vnoremap <Space> za
    "Save folds on save
    augroup folds
        autocmd!
        autocmd BufWinLeave * mkview
        autocmd BufWinEnter * silent! loadview
    augroup END

"LSP configuration
:lua << EOF
    local nvim_lsp = require('lspconfig')
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

      -- Set some keybinds conditional on server capabilities
      if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      end

      -- Set autocommands conditional on server_capabilities
      if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
          augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]], false)
      end
    end

    -- Use a loop to conveniently both setup defined servers 
    -- and map buffer local keybindings when the language server attaches
    local servers = { "pyright", "tsserver" }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup { on_attach = on_attach }
    end
EOF

"LSP autocompletion
    "" Use <Tab> and <S-Tab> to navigate through popup menu
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    "Completion on every buffer
    autocmd BufEnter * lua require'completion'.on_attach()

    " Set completeopt to have a better completion experience
    set completeopt=menuone,noinsert,noselect

    " Avoid showing message extra message when using completion
    set shortmess+=c
