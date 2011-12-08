" Vim syntax file
" Language:	JavaScript
" Maintainer:	Claudio Fleiner <claudio@fleiner.com>
" Updaters:	Scott Shattuck (ss) <ss@technicalpursuit.com>
" URL:		http://www.fleiner.com/vim/syntax/javascript.vim
" Changes:	(ss) added keywords, reserved words, and other identifiers
"		(ss) repaired several quoting and grouping glitches
"		(ss) fixed regex parsing issue with multiple qualifiers [gi]
"		(ss) additional factoring of keywords, globals, and members
" Last Change:	2010 Mar 25
"
" Standard javascript.vim {{{1
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet javaScript_fold

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("javaScript_fold")
  unlet javaScript_fold
endif


syn keyword javaScriptCommentTodo      TODO FIXME XXX TBD contained
syn match   javaScriptLineComment      "\/\/.*" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  javaScriptComment	       start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptSpecial	       "\\\d\d\d\|\\."
syn region  javaScriptStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=javaScriptSpecial,@htmlPreproc
syn region  javaScriptStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=javaScriptSpecial,@htmlPreproc

syn match   javaScriptSpecialCharacter "'\\.'"
syn match   javaScriptNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  javaScriptRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline

syn keyword javaScriptConditional	if else switch
syn keyword javaScriptRepeat		while for do in
syn keyword javaScriptBranch	   	break continue
syn keyword javaScriptOperator		new delete instanceof typeof
syn keyword javaScriptType		    Array Boolean Date Function Number Object String RegExp
syn keyword javaScriptStatement		return with
syn keyword javaScriptBoolean		true false
syn keyword javaScriptNull		    null undefined
syn keyword javaScriptIdentifier	arguments this var let
syn keyword javaScriptLabel		    case default
syn keyword javaScriptException		try catch finally throw
syn keyword javaScriptMessage		alert confirm prompt status
syn keyword javaScriptGlobal		self window top parent
syn keyword javaScriptMember		document event location 
syn keyword javaScriptDeprecated	escape unescape
syn keyword javaScriptReserved		abstract boolean byte char class const debugger double enum export extends final float goto implements import int interface long native package private protected public short static super synchronized throws transient volatile 

if exists("javaScript_fold")
    syn match	javaScriptFunction	"\<function\>"
    syn region	javaScriptFunctionFold	start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match javaScriptSync	grouphere javaScriptFunctionFold "\<function\>"
    syn sync match javaScriptSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword javaScriptFunction	function
    syn match	javaScriptBraces	   "[{}\[\]]"
    syn match	javaScriptParens	   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "javascript"
  syn sync ccomment javaScriptComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink javaScriptComment		    Comment
  HiLink javaScriptLineComment		Comment
  HiLink javaScriptCommentTodo		Todo
  HiLink javaScriptSpecial		    Special
  HiLink javaScriptStringS		    String
  HiLink javaScriptStringD		    String
  HiLink javaScriptCharacter		Character
  HiLink javaScriptSpecialCharacter	javaScriptSpecial
  HiLink javaScriptNumber		    javaScriptValue
  HiLink javaScriptConditional		Conditional
  HiLink javaScriptRepeat		    Repeat
  HiLink javaScriptBranch		    Conditional
  HiLink javaScriptOperator		    Operator
  HiLink javaScriptType			    Type
  HiLink javaScriptStatement		Statement
  HiLink javaScriptFunction		    Function
  HiLink javaScriptBraces		    Function
  HiLink javaScriptError		    Error
  HiLink javaScrParenError		    javaScriptError
  HiLink javaScriptNull			    Keyword
  HiLink javaScriptBoolean		    Boolean
  HiLink javaScriptRegexpString		String

  HiLink javaScriptIdentifier		Identifier
  HiLink javaScriptLabel		    Label
  HiLink javaScriptException		Exception
  HiLink javaScriptMessage		    Keyword
  HiLink javaScriptGlobal		    Keyword
  HiLink javaScriptMember		    Keyword
  HiLink javaScriptDeprecated		Exception 
  HiLink javaScriptReserved		    Keyword
  HiLink javaScriptDebug		    Debug
  HiLink javaScriptConstant		    Label

  delcommand HiLink
endif

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif

" myvi Settings{{{1
"
" keyword {{{1 
"
syn keyword Exception		  try catch finally throw
syn keyword Function	      function 
syn keyword javaScriptType    FileReader 
syn keyword Statement         false true

syn keyword Methods           dataTransfer filesonload target result 
syn keyword Methods           innerHTML name size length type files
syn keyword Methods           onload style display 
"syn keyword Methods               


syn keyword Builtin          split concat getElementById join readAsText
syn keyword Builtin          replace match addEventListener preventDefault
syn keyword Builtin          push typeof stopPropagation createElement
syn keyword Builtin          toString pop parseFloat    
"syn keyword Builtins               
"syn keyword Builtins              

" match  {{{1 

syn match Arithmetic "+\|-\|\*\|\*\*\|%\|/\|<<\|>>\|&\|\^\|\~"
syn match Assignment "=\|+=\|-=\|\*=\|/=\|%=\|&=\||=\|\^=\|>>="
syn match Assignment "<<=\|\*\*="
syn match Comparison "==\||=\|<=\|>=\|<\|>"

syn match Misspell       "ouput\|auput\|autput\|aray\|Aray"


syn match   Number	   "\<0[oO]\=\o\+[Ll]\=\>"
syn match   Number	   "\<0[xX]\x\+[Ll]\=\>"
syn match   Number	   "\<0[bB][01]\+[Ll]\=\>"
syn match   Number	   "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   Number	   "\<\d\+[jJ]\>"
syn match   Number	   "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   Special      "\\n\|\\r"

syn match   Conditional   "&&\|||\||\|?\|:"
syn match   Comment        "\/\/.*" 
syn match   CommentSkip   "^[ \t]*\*\($\|[ \t]\+\)"

syn match ParenError     display ')'
syn match BracketError   display ']'
syn match CurlyError     display '}'


" clusters {{{1     
syn cluster jsAll  contains=javaScriptLineComment
syn cluster jsALL  add=javaScriptComment
syn cluster jsAll  add=javaScriptSpecial
syn cluster jsAll  add=javaScriptStringS
syn cluster jsAll  add=javaScriptStringD
syn cluster jsAll  add=javaScriptCharacter
syn cluster jsAll  add=javaScriptSpecialCharacter
syn cluster jsAll  add=javaScriptNumber
syn cluster jsAll  add=javaScriptConditional
syn cluster jsAll  add=javaScriptRepeat
syn cluster jsAll  add=javaScriptBranch
syn cluster jsAll  add=javaScriptOperator
syn cluster jsAll  add=javaScriptType
syn cluster jsAll  add=javaScriptStatement
syn cluster jsAll  add=javaScriptFunction
syn cluster jsAll  add=javaScriptBraces
syn cluster jsAll  add=javaScriptError
syn cluster jsAll  add=javaScrParenError
syn cluster jsAll  add=javaScriptNull
syn cluster jsAll  add=javaScriptBoolean
syn cluster jsAll  add=javaScriptRegexpString
syn cluster jsAll  add=javaScriptIdentifier
syn cluster jsAll  add=javaScriptLabel
syn cluster jsAll  add=javaScriptException
syn cluster jsAll  add=javaScriptMessage
syn cluster jsAll  add=javaScriptGlobal
syn cluster jsAll  add=javaScriptMember
syn cluster jsAll  add=javaScriptDeprecated
syn cluster jsAll  add=javaScriptReserved
syn cluster jsAll  add=javaScriptDebug
syn cluster jsAll  add=javaScriptConstant
syn cluster jsAll  add=javaScriptCommentTodo,Special,Statement
syn cluster jsAll  add=Assignment,Arithmetic,Comparison,Methods
syn cluster jsAll  add=Number,ParenError,BracketError,CurlyError
syn cluster jsAll  add=Function,Exception,Builtin,Misspell,Comment

" region {{{1   
syn region  javaScriptComment	       start="/\*"  end="\*/" 

syn region  jsBracket0   fold   transparent matchgroup=hlLevel0 start='\[' end=']'            contains=@jsAll,jsBracket1,jsCurly1,jsParen1
syn region  jsBracket1          transparent matchgroup=hlLevel1 start='\[' end=']'  contained contains=@jsAll,jsBracket2,jsCurly2,jsParen2 
syn region  jsBracket2          transparent matchgroup=hlLevel2 start='\[' end=']'  contained contains=@jsAll,jsBracket3,jsCurly3,jsParen3 
syn region  jsBracket3          transparent matchgroup=hlLevel3 start='\[' end=']'  contained contains=@jsAll,jsBracket0,jsCurly0,jsParen0 

syn region  jsCurly0     fold   transparent matchgroup=hlLevel0 start='{' end='}'           contains=@jsAll,jsCurly1,jsBracket1,jsParen1
syn region  jsCurly1            transparent matchgroup=hlLevel1 start='{' end='}' contained contains=@jsAll,jsCurly2,jsBracket2,jsParen2 
syn region  jsCurly2            transparent matchgroup=hlLevel2 start='{' end='}' contained contains=@jsAll,jsCurly3,jsBracket3,jsParen3 
syn region  jsCurly3            transparent matchgroup=hlLevel3 start='{' end='}' contained contains=@jsAll,jsCurly0,jsBracket0,jsParen0 

syn region  jsParen0     fold   transparent matchgroup=hlLevel0 start='(' end=')'           contains=@jsAll,jsParen1,jsBracket1,jsCurly1
syn region  jsParen1            transparent matchgroup=hlLevel1 start='(' end=')' contained contains=@jsAll,jsParen2,jsBracket2,jsCurly2 
syn region  jsParen2            transparent matchgroup=hlLevel2 start='(' end=')' contained contains=@jsAll,jsParen3,jsBracket3,jsCurly3 
syn region  jsParen3            transparent matchgroup=hlLevel3 start='(' end=')' contained contains=@jsAll,jsParen0,jsBracket0,jsCurly0 

" highlight {{{1     

if &bg == "dark"
    hi default   hlLevel0 ctermfg=84   guifg=#5fff87
    hi default   hlLevel1 ctermfg=93   guifg=#8700ff      
    hi default   hlLevel2 ctermfg=160  guifg=#d70000    
    hi default   hlLevel3 ctermfg=69   guifg=#5f87ff  
else
    hi default   hlLevel0 ctermfg=red         guifg=red3
    hi default   hlLevel1 ctermfg=darkyellow  guifg=orangered3
    hi default   hlLevel2 ctermfg=darkgreen   guifg=orange2
    hi default   hlLevel3 ctermfg=blue        guifg=yellow3
endif

" ---------------------------------------------------------------------
" Modelines: {{{1
" vim: fdm=marker ft=vim ts=4
