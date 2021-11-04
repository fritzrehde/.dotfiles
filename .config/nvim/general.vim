set nocompatible

" UI
syntax enable
colorscheme nord
set termguicolors
set number
set noshowcmd
set wrap
set linebreak
set list 

" UX
set scrolloff=2
set splitbelow splitright
set nostartofline
set backspace=indent,eol,start

" General
set clipboard=unnamed
set encoding=utf-8
filetype on

" Tabs
set tabstop=2
set softtabstop=0
set noexpandtab
set shiftwidth=2
set autoindent
set listchars=tab:│\ 

" Search
set ignorecase
set nohlsearch

" Cursor
set guicursor=i:ver90
set mouse=a
set cursorline
set colorcolumn=99999 " bug fix for indent-blankline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " disable auto comment in next line

" Bell
set noerrorbells
set vb t_vb=

" Nord theme
let g:nord_cursor_line_number_background=1

" Syntax
au BufRead *.minijava set filetype=java
