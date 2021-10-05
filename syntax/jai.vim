if exists("b:current_syntax")
   finish
endif

function! FindJaiModule(filename)
	if !exists('g:jai_modules')
		return a:filename . '.jai'
	endif
	let jai_module=substitute(a:filename,'^',g:jai_modules,'g')
	if isdirectory(jai_module)
		return jai_module . '/module.jai'
	else
		return jai_module . '.jai'
	endif
endfunction

setlocal suffixesadd+=jai
set includeexpr=FindJaiModule(v:fname)
setlocal commentstring=//\ %s

syntax keyword jaiUsing using
syntax keyword jaiCast cast

syntax keyword jaiStruct struct
syntax keyword jaiUnion union
syntax keyword jaiEnum enum enum_flags

syntax keyword jaiIf if
syntax keyword jaiIfx ifx
syntax keyword jaiThen then
syntax keyword jaiElse else
syntax keyword jaiCase case
syntax keyword jaiFor for
syntax keyword jaiContinue continue
syntax keyword jaiBreak break
syntax keyword jaiRemove remove
syntax keyword jaiWhile while

syntax keyword jaiDataType void string int float float32 float64 u8 u16 u32 u64 s8 s16 s32 s64 bool
syntax keyword jaiBool true false
syntax keyword jaiNull null

syntax keyword jaiReturn return
syntax keyword jaiDefer defer

syntax keyword jaiInline inline
syntax keyword jaiNoInline no_inline

syntax keyword jaiSOA SOA
syntax keyword jaiAOS AOS

syntax keyword jaiIt it it_index

syntax keyword jaiTypeInfo size_of type_of type_info
syntax keyword jaiInterface interface
syntax keyword jaiIsConstant is_constant

syntax keyword jaiContext context push_context

syntax keyword jaiOperator operator

syntax keyword jaiInitializerOf initializer_of

syntax region jaiString start=/\v"/ skip=/\v\\./ end=/\v"/

syntax keyword jaiAutoCast xx

syntax match jaiFunction "\v<\w+>(\s*:[:=]\s*\(.*\)[^{]*\{)@="
"The lookaheads make sure we’re not accidentally matching a function
syntax match jaiConstantDeclaration "\v<\w+(\\\s*\w+)*>(,\s*<\w+(\\\s*\w+)*>)*(\s*::\s*((\([^{]*$)|([^( \t])))@=" display
syntax match jaiVariableDeclaration "\v<\w+(\\\s*\w+)*>(,\s*<\w+(\\\s*\w+)*>)*(\s*:[^:]\s*((\([^{]*$)|([^( \t])))@=" display
syntax match jaiTagNote "@\<\w\+\>" display

syntax match jaiClass "\v<[A-Z]\w+>" display
syntax match jaiConstant "\v<[A-Z0-9,_]+>" display

syntax match jaiInteger "\<\d\+\>" display
syntax match jaiFloat "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=" display
syntax match jaiHex "\<0[x\|X][0-9A-Fa-f_]\+\>" display
syntax match jaiHexFloat "\<0[h\|H][0-9A-Fa-f_]\+\>" display
syntax match jaiBinary "\<0[b\|B][0-1_]\+\>" display

syntax match jaiDirective "#\<\w\+\>" display

syntax match jaiTemplate "$\<\w\+\>"
syntax match jaiAutobake "$$\<\w\+\>"

syntax match jaiCommentNote "@\<\w\+\>" contained display
syntax match jaiLineComment "//.*" contains=jaiCommentNote
syntax region jaiBlockComment start=/\v\/\*/ end=/\v\*\// contains=jaiBlockComment, jaiCommentNote
" Maybe scan back to find the beginning of block comments?
syntax sync minlines=200


highlight link jaiIt Identifier
highlight link jaiUsing Keyword
highlight link jaiCast Keyword
highlight link jaiAutoCast Keyword
highlight link jaiReturn Keyword
highlight link jaiDefer Keyword
highlight link jaiTypeInfo Keyword
highlight link jaiInterface Keyword
highlight link jaiIsConstant Keyword
highlight link jaiContext Keyword
highlight link jaiOperator Keyword
highlight link jaiInitializerOf Keyword

highlight link jaiInline Keyword
highlight link jaiNoInline Keyword

highlight link jaiString String

highlight link jaiStruct Structure
highlight link jaiUnion Structure
highlight link jaiEnum Structure

highlight link jaiFunction Function
highlight link jaiVariableDeclaration Identifier
highlight link jaiConstantDeclaration Constant

highlight link jaiDirective PreProc
highlight link jaiIf Conditional
highlight link jaiIfx Conditional
highlight link jaiThen Conditional
highlight link jaiElse Conditional
highlight link jaiCase Conditional
highlight link jaiContinue Keyword
highlight link jaiBreak Keyword
highlight link jaiRemove Keyword
highlight link jaiFor Repeat
highlight link jaiWhile Repeat

highlight link jaiLineComment Comment
highlight link jaiBlockComment Comment
highlight link jaiCommentNote Todo

highlight link jaiClass Type

highlight link jaiTemplate Constant
highlight link jaiAutobake Constant

highlight link jaiTagNote Identifier
highlight link jaiDataType Type
highlight link jaiBool Boolean
highlight link jaiConstant Constant
highlight link jaiNull Type
highlight link jaiInteger Number
highlight link jaiFloat Float
highlight link jaiHex Number
highlight link jaiHexFloat Number
highlight link jaiBinary Number

highlight link jaiSOA Keyword
highlight link jaiAOS Keyword

let b:current_syntax = "jai"
