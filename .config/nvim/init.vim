let rootDirectory = '~/.config/nvim'

" Load plugins using 'vim-plug'
" Please note that 'vim-plug' needs to be installed
call plug#begin(rootDirectory . '/plugged')
exec 'source ' . rootDirectory . '/plugs.vim'
call plug#end()

" Load all plugins configuration files inside
" 'plugins' folder that ends with '.rc.vim'
for f in split(glob(rootDirectory . '/settings/**/*.rc.vim'), '\n')
    exe 'source' f
endfor

" Line numbers
set number
set relativenumber


set list " Highlight unwanted spaces
set clipboard+=unnamedplus " Use system clipboard
set cursorline " Highlight current line
set nowrap " Prevent line wrap
set ic " Make case insensitive search default

" Keep N lines visible around the cursor position for X and Y axis
set scrolloff=20
set sidescrolloff=30

" Configure indentation
set tabstop=2
set shiftwidth=2
set expandtab

" Statusbar
set laststatus=2
set noshowmode


colorscheme material
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
let g:material_theme_style = 'lighter'
