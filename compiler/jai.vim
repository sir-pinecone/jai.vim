" Vim compiler file
" Compiler:         Jai
" Maintainer:       Raphael Luba <raphael@leanbyte.com>
" Latest Revision:  2020-10-05

if exists("current_compiler")
  finish
endif
let current_compiler="jai"

function! FindJaiEntrypoint(filename)
	let buildfile = 'build.jai'
	if exists("g:jai_entrypoint")
		return g:jai_entrypoint
	else 
		if filereadable(buildfile)
			return buildfile
		else
			return a:filename
		endif
	endif
endfunction

let &l:makeprg="jaic_vim -no_color " . FindJaiEntrypoint(expand('%'))

let s:cpo_save = &cpo
set cpo-=C

CompilerSet errorformat=
	\%f:%l\\,%c:\ Error:\ %m,
	\%f:%l\\,%c:\ %m,
	\%m\ (%f:%l),


let &cpo = s:cpo_save
unlet s:cpo_save
