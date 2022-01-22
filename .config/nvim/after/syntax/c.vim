" Operators
sy match  cOperator      '[+\-\~!\*/%<>=&\^|?:]'
hi def link cOperator Operator

" Delimiters
sy match  cDelimiter     '[()\[\]]'
sy match  cDelimiter2    '[.,;{}]'
hi def link cDelimiter Delimiter
hi def link cDelimiter2 Delimiter2

" Functions
sy match cUserFunction "\<\h\w*\>\(\s\|\n\)*("me=e-1 contains=cType,cDelimiter,cDefine
sy match cUserFunctionPointer "(\s*\*\s*\h\w*\s*)\(\s\|\n\)*(" contains=cDelimiter,cOperator
hi def link cUserFunction cFunction
hi def link cUserFunctionPointer cFunction
hi def link cFunction Function

" Comments
sy match cComment '//.*'
sy region cComment start='/\*' end='\*/'
hi def link cComment Comment

" Todo
sy keyword cTodo TODO FIXME containedin=.*Comment
hi def link cTodo Todo
