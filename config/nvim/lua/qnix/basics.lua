local M = {}

function M.setup()
  vim.cmd [[
    syntax on
    filetype on
    filetype plugin indent on
    set number relativenumber
    set termguicolors
    set signcolumn=yes
    set mouse=a

    " searching
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase

    " wrapping
    set wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap j gj
    noremap k gk
    noremap <Home> g<Home>
    noremap <End>  g<End>

    " file encoding
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8
    set fileformats=unix,dos,mac

    " shell
    if exists('$SHELL')
        set shell=$SHELL
    else
        set shell=/bin/sh
    endif

    " listchars
    set nolist
    " set listchars=tab:>-,space:⋅·•,eol:↴
    set listchars=tab:▸\ ,space:•,eol:↴

    " indentation
    set expandtab
    set tabstop=2
    set shiftwidth=2

    " clear highlight
    nnoremap <silent> <esc> :noh<return><esc>
  ]]
end

return M
