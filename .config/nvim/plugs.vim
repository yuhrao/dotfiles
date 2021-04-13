Plug 'kaicataldo/material.vim', { 'branch': 'main' } " Material theme

Plug 'itchyny/lightline.vim' " Better status

Plug 'lilydjwg/colorizer' " Colorize hex colors codes

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Completions

Plug 'jiangmiao/auto-pairs' " Auto pairs

Plug 'preservim/nerdcommenter' " Code comments

Plug 'tpope/vim-surround' " Quoting/parenthesizing utilities

Plug 'junegunn/vim-easy-align' " Text aligning tool

" File System Explorer (Fern)
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'


" Syntax
" NOTE: Vim version must be NVIM Nightly (>=0.5)
" NOTE: Don't forget to run ':TSInstall all'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'


" Git wrapper
Plug 'tpope/vim-fugitive'

" Git commit browser. Depends on 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Git blamer inspired by VSCode's GitLens plugin
Plug 'APZelos/blamer.nvim'

" Diff markers
Plug 'airblade/vim-gitgutter'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Snippets
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
