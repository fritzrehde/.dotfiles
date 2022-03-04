let mapleader=","

" copy line without line break
nnoremap Y mQ^y$`Q

" align search results in middle
nnoremap n nzz
nnoremap N Nzz

" redo
nnoremap U <C-r>

" page up/down
nnoremap J <C-d>
nnoremap K <C-u>

" commenting
nnoremap <leader><Space> :call ToggleComment()<cr>
vnoremap <leader><Space> :call ToggleComment()<cr>

" auto-close brackets
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" continue highlighting after indentation
vnoremap < <gv
vnoremap > >gv

cnoremap <silent> <expr> <enter> CenterSearch()
