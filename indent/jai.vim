if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nosmartindent
setlocal nolisp
setlocal autoindent

setlocal indentexpr=GetJaiIndent(v:lnum)
setlocal indentkeys+=;

if exists("*GetJaiIndent")
  finish
endif

let s:jai_indent_defaults = {
      \ 'default': function('shiftwidth'),
      \ 'case_labels': function('shiftwidth') }

function! s:indent_value(option)
  let Value = exists('b:jai_indent_options')
            \ && has_key(b:jai_indent_options, a:option) ?
            \ b:jai_indent_options[a:option] :
            \ s:jai_indent_defaults[a:option]

  if type(Value) == type(function('type'))
    return Value()
  endif
  return Value
endfunction

function! GetJaiIndent(lnum)
  let prev = prevnonblank(a:lnum-1)

  if prev == 0
    return 0
  endif

  let prevline = getline(prev)
  let line = getline(a:lnum)

  let ind = indent(prev)

  if prevline =~ '[({]\s*$'
    let ind += s:indent_value('default')
  elseif prevline =~ 'case\s*\S*;'
    let ind += s:indent_value('default')
  endif

  if line =~ '^\s*[)}]'
    let ind -= s:indent_value('default')
  elseif line =~ 'case\s*\S*;'
    let ind -= s:indent_value('case_labels')
  endif

  return ind
endfunction
