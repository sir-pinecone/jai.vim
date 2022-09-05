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

function! FindJaiCompiler()
	if exists("g:jai_compiler")
		return g:jai_compiler
	else
		if has("win64") || has("win32") || has("win16")
			return "jai.exe"
		else
			return "jai-linux"
		endif
	endif
endfunction

function! FindJaiModules()
	if exists("g:jai_local_modules")
		return " -import_dir " . g:jai_local_modules
	else 
        let modules_dir = getcwd() . '/modules'
		if isdirectory(modules_dir)
			return " -import_dir " . modules_dir
		else
            let local_modules_dir = 'Local_Modules'
            if isdirectory(local_modules_dir)
                return " -import_dir " . local_modules_dir
            else
                return ""
            endif
		endif
	endif
endfunction


let &l:makeprg=FindJaiCompiler() . " -no_color " . FindJaiEntrypoint(expand('%')) . FindJaiModules()

let s:cpo_save = &cpo
set cpo-=C

CompilerSet errorformat=
	\%f:%l\\,%c:\ Error:\ %m,
	\%f:%l\\,%c:\ %m,
	\%m\ (%f:%l),


let &cpo = s:cpo_save
unlet s:cpo_save
