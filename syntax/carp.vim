if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'carp') == -1
  
" Vim syntax file
" Language:     Carp
" Maintainer:   Veit Heller <veit@veitheller.de>
" URL:          http://github.com/hellerve/carp-vim.git
" Description:  Contains all of the keywords in #lang carp

if exists("b:current_syntax")
  finish
endif

syn match carpError ,[]})],

if version < 600
  set iskeyword=33,35-39,42-43,45-58,60-63,65-90,94,95,97-122,124,126,_
else
  setlocal iskeyword=33,35-39,42-43,45-58,60-63,65-90,94,95,97-122,124,126,_
endif

syn keyword carpSyntax def defn let do if while ref address set! the
syn keyword carpSyntax defmacro defdynamic quote car cdr cons list array
syn keyword carpSyntax expand deftype register system-include register-type
syn keyword carpSyntax defmodule copy use module defalias definterface eval
syn keyword carpSyntax expand instantiate type info help quit env build run
syn keyword carpSyntax cat use project-set! local-include system-include
syn keyword carpSyntax add-cflag add-lib project load reload

syn keyword carpFunc Int Float Double Bool String Char Array Fn Ref Long
syn keyword carpFunc not or and + - * / = /= >= <= > < inc dec
syn keyword carpFunc println print get-line from-string mod seed random
syn keyword carpFunc random-between str mask delete append count duplicate
syn keyword carpFunc cstr chars from-chars to-int from-int sin cos sqrt acos
syn keyword carpFunc atan2 exit time srand for cond floor abs neg to-float
syn keyword carpFunc from-float tan asin atan cosh sinh tanh exp frexp ldexp
syn keyword carpFunc log log10 modf pow ceil clamp approx refstr foreach
syn keyword carpFunc => ==> repeat nth replicate range raw aset aset! count
syn keyword carpFunc push-back pop-back sort index-of element-count


syn match carpSymbol ,\k+,  contained
syn match carpTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE)/ containedin=carpComment,carpString

syn cluster carpNormal  contains=carpSyntax,carpFunc,carpDelimiter
syn cluster carpQuotedStuff  contains=carpSymbol
syn cluster carpQuotedOrNormal  contains=carpDelimiter

syn region carpQuotedStruc start="@("rs=s+2 end=")"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained
syn region carpQuotedStruc start="&("rs=s+2 end=")"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained
syn region carpQuotedStruc start="("rs=s+1 end=")"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained
syn region carpQuotedStruc start="\["rs=s+1 end="\]"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained

syn cluster carpQuotedStuff add=carpQuotedStruc

syn region carpStruc matchgroup=Delimiter start="@("rs=s+2 matchgroup=Delimiter end=")"re=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="&("rs=s+2 matchgroup=Delimiter end=")"re=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="&"rs=s+1 end=![ \t()\[\]";]!me=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="@"rs=s+1 end=![ \t()\[\]";]!me=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="("rs=s+1 matchgroup=Delimiter end=")"re=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="\["rs=s+1 matchgroup=Delimiter end="\]"re=e-1 contains=@carpNormal

syn region carpString start=/\%(\\\)\@<!"/ skip=/\\[\\"]/ end=/"/

syn cluster carpNormal          add=carpError,carpStruc,carpString
syn cluster carpQuotedOrNormal  add=carpString

syn match carpNumber    "\<[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?[lf]\?\>" contains=carpContainedNumberError
syn match carpNumber    "\<[-+]\?\d\+/\d\+[lf]\?\>" contains=carpContainedNumberError


syn keyword carpBoolean  true false

syn match carpChar    "\<\\.\w\@!"

syn region carpQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal
syn region carpQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=@carpQuotedStuff,@carpQuotedOrNormal

syn cluster carpNormal  add=carpNumber,carpBoolean,carpChar
syn cluster carpQuotedOrNormal  add=carpNumber,carpBoolean

syn match carpComment /;.*$/ contains=@Spell

syn region carpQuoted matchgroup=Delimiter start="#['`]"rs=s+2 end=![ \t()\[\]";]!re=e-1,me=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal
syn region carpQuoted matchgroup=Delimiter start="#['`]("rs=s+3 matchgroup=Delimiter end=")"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal

syn cluster carpNormal  add=carpQuoted,carpComment
syn cluster carpQuotedOrNormal  add=carpComment

syn sync match matchPlace grouphere NONE "^[^ \t]"

if version >= 508 || !exists("carp_syntax_init")
  if version < 508
    let carp_syntax_init = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink carpSyntax             Statement
  HiLink carpFunc               Function
  HiLink carpCopy               Function

  HiLink carpString             String
  HiLink carpChar               Character
  HiLink carpBoolean            Boolean

  HiLink carpNumber             Number
  HiLink carpNumberError        Error
  HiLink carpContainedNumberError Error

  HiLink carpQuoted             Structure
  HiLink carpQuotedStruc        Structure
  HiLink carpSymbol             Structure
  HiLink carpAtom               Structure

  HiLink carpDelimiter          Delimiter
  HiLink carpConstant           Constant

  HiLink carpTodo               Todo
  HiLink carpComment            Comment
  HiLink carpError              Error
  delcommand HiLink
endif

let b:current_syntax = "carp"

endif