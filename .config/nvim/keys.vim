let mapleader=","

" Improved defaults
nnoremap Y y$

" Align search results in middle
nnoremap n nzz
nnoremap N Nzz

" Redo
nnoremap U <C-r>

" Commenting
nnoremap <leader><Space> :call ToggleComment()<cr>
vnoremap <leader><Space> :call ToggleComment()<cr>

" Auto-close brackets
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Continue highlighting after indentation
vnoremap < <gv
vnoremap > >gv

cnoremap <silent> <expr> <enter> CenterSearch()
