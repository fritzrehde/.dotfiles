call plug#begin('~/.config/nvim/plugged')

for f in split(glob('~/.config/nvim/plugins/*.vim'), '\n')
    exe 'source' f
endfor

call plug#end()
