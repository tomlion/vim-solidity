" Vim syntax file
" Language:     Solidity
" Maintainer:   TovarishFin (tovarishFin@gmail.com)
" URL:          https://github.com/TovarishFin/vim-solidity

if exists("b:current_syntax")
  finish
endif

" Common Groups
syn match     solComma            ','

" Common Groups Highlighting
hi def link   solParens           Normal
hi def link   solComma            Normal

" Simple Types
syn match     solValueType        /\<uint\d*\>/
syn match     solValueType        /\<int\d*\>/
syn match     solValueType        /\<fixed\d*\>/
syn match     solValueType        /\<ufixed\d*\>/
syn match     solValueType        /\<bytes\d*\>/
syn match     solValueType        /\<address\>/
syn match     solValueType        /\<string\>/
syn match     solValueType        /\<bool\>/
syn match     solTypeCast         /uint\d*\ze\s*(/
syn match     solTypeCast         /int\d*\ze\s*(/
syn match     solTypeCast         /ufixed\d*\ze\s*(/
syn match     solTypeCast         /bytes\*\ze\s*(/
syn match     solTypeCast         /address\ze\s*(/
syn match     solTypeCast         /string\ze\s*(/
syn match     solTypeCast         /bool\ze\s*(/

hi def link   solValueType        Type
hi def link   solTypeCast         Type

" Complex Types
syn keyword   solMapping          mapping matchgroup=solStructure
syn keyword   solEnum             enum nextgroup=solEnumBody skipempty skipwhite
syn region    solEnumBody         matchgroup=solParens start='(' end=')' contained contains=solComma,solValueType,solStorageType keepend
syn keyword   solStruct           struct nextgroup=solStructBody skipempty skipwhite
syn region    solStructBody       matchgroup=solParens start='{' end='}' contained contains=solComma,solValueType,solStorageType,solStruct,solEnum,solMapping keepend

hi def link   solMapping          Define
hi def link   solEnum             Define
hi def link   solStruct           Define

" Operators
syn match     solOperator         /\(!\||\|&\|+\|-\|<\|>\|=\|%\|\/\|*\|\~\|\^\)/

hi def link   solOperator         Operator

" Numbers
syntax match  solNumber           /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>/
syntax match  solNumber           /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/
syntax region solString           start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+

hi def link   solNumber           Number
hi def link   solString           String

" Functions
syn keyword   solConstructor      constructor nextgroup=solFuncParam skipwhite
syn keyword   solFunction         function nextgroup=solFuncName skipwhite
syn match     solFuncName         /\<[a-zA-Z_][0-9a-zA-z_$]*/ contained nextgroup=solFuncParam skipwhite
syn region    solFuncParam        matchgroup=solParens start='(' end=')' contained contains=solComma,solValueType,solStorageType nextgroup=solFuncModCustom,solFuncReturn,solFuncBody keepend skipempty skipwhite
syn keyword   solFuncModifier     external internal payable public pure view 
syn match     solFuncModCustom    /\<[a-zA-Z_][0-9a-zA-z_$]*/ contained nextgroup=solFuncParam,solFuncModCustom,solFuncBody skipempty skipwhite 
syn region    solFuncReturn       matchgroup=solParens start='(' end=')' contained contains=solValueType,solStorageType,solFuncBody
syn region    solFuncBody         start='{' end='}' contained contains=solEmitEvent,solTypeCast,solMethod,solValueType,solConstant,solKeyword,solConditional,solRepeat,solLabel,solException,solStructure,solStorageType,solOperator,solNumber,solString,solFuncCall skipempty skipwhite keepend transparent
syn match     solFuncCall         /\<[a-zA-Z_][0-9a-zA-z_$]*\(uint\|int\|ufixed\|bytes\|address\|string\|bool\)\@<!\((\)\@=/ contained


hi def link   solFunction         Define
hi def link   solConstructor      Define
hi def link   solFuncName         Function
hi def link   solFuncModifier     Keyword
hi def link   solFuncModCustom    Keyword
hi def link   solFuncCall         Function

" Modifiers
syn keyword   solModifier         modifier nextgroup=solModifiername skipwhite
syn match     solModifierName     /\<[a-zA-Z_][0-9a-zA-z_$]*/ contained nextgroup=solModifierParam skipwhite
syn region    solModifierParam    matchgroup=solParens start='(' end=')' contained contains=solComma,solValueType,solStorageType nextgroup=solModifierBody skipwhite skipempty 
syn region    solModifierBody     start='{' end='}' contained contains=solEmitEvent,solTypeCast,solMethod,solFuncCall,solModifierInsert,solValueType,solConstant,solKeyword,solConditional,solRepeat,solLabel,solException,solStructure,solStorageType,solOperator,solNumber,solString,solFuncCall skipempty skipwhite keepend transparent
syn match     solModifierInsert   /\<_\>/ contained 

hi def link   solModifier         Define
hi def link   solModifierName     Function
hi def link   solModifierInsert   Function

" Contracts, Librares, Interfaces
syn match     solContract         /\<\%(contract\|library\|interface\)\>/ nextgroup=solContractName skipwhite
syn match     solContractName     /\<[a-zA-Z_][0-9a-zA-Z_]*/ contained nextgroup=solContractParent skipwhite
syn region    solContractParent   start='is' end='{' contains=solContractName,solComma,solInheritor
syn match     solInheritor        'is' contained
syn region    solLibUsing         start='using' end='for' contains=solLibName
syn match     solLibName          /[a-zA-Z_][0-9a-zA-Z_]*\s*\zefor/ 

hi def link   solContract         Define
hi def link   solContractName     Function
hi def link   solInheritor        Keyword
hi def link   solLibUsing         Special
hi def link   solLibName          Type

" Events
syn match     solEvent            'event' nextgroup=solEventName,solEventParams skipwhite
syn match     solEventName        /\<[a-zA-Z_][0-9a-zA-Z_]*/ nextgroup=solEventParam contained skipwhite
syn region    solEventParam       matchgroup=solParens start='(' end=')' contains=solComma,solValueType,solEventParamMod,other contained skipwhite skipempty
syn match     solEventParamMod    /indexed/ contained
syn keyword   solEmitEvent        emit 

hi def link   solEvent            Define
hi def link   solEventName        Function
hi def link   solEventParamMod    Keyword
hi def link   solEmitEvent        Special

" Comments
syn keyword   solTodo             TODO FIXME XXX TBD contained
syn region    solComment          start=/\/\// end=/$/ contains=solTodo
syn region    solComment          start=/\/\*/ end=/\*\// contains=solTodo

hi def link   solTodo             Todo
hi def link   solComment          Comment

" Natspec
syn match     solNatspecTag       /@dev\>/ contained
syn match     solNatspecTag       /@title\>/ contained
syn match     solNatspecTag       /@author\>/ contained
syn match     solNatspecTag       /@notice\>/ contained
syn match     solNatspecTag       /@param\>/ contained 
syn match     solNatspecTag       /@return\>/ contained
syn match     solNatspecParam     /\(@param\s*\)\@<=\<[a-zA-Z_][0-9a-zA-Z_]*/
syn region    solNatspecBlock     start=/\/\/\// end=/$/ contains=solTodo,solNatspecTag,solNatspecParam
syn region    solNatspecBlock     start=/\/\*\{2}/ end=/\*\// contains=solTodo,solNatspecTag,solNatspecParam

hi def link   solNatspecTag       SpecialComment
hi def link   solNatspecBlock     Comment
hi def link   solNatspecParam     Define

" Constants
syn keyword   solConstant         true false wei szabo finney ether seconds minutes hours days weeks years now super 
syn keyword   solConstant         block msg now tx this 

hi def link   solConstant         Constant

" Keywords
syn keyword   solKeyword          abstract anonymous as assembly constant default
syn keyword   solKeyword          delete final in inline 
syn keyword   solKeyword          let match new of pragma 
syn keyword   solKeyword          relocatable static type var 

hi def link   solKeyword          Keyword

" Builtin Methods
syn match     solMethod           /require\s*\ze(/ 
syn match     solMethod           /return\s*\ze(/ 
syn match     solMethod           /returns\s*\ze(/ 
syn match     solMethod           /import\s*\ze"/ 
syn match     solMethod           /keccak256\s*\ze(/
syn match     solMethod           /sha256\s*\ze(/
syn match     solMethod           /ripemd160\s*\ze(/
syn match     solMethod           /ecrecover\s*\ze(/
syn match     solMethod           /addmod\s*\ze(/
syn match     solMethod           /mullmod\s*\ze(/
syn match     selfdestruct        /selfdestruct\s*\ze(/

hi def link   solMethod           Special

" Miscellaneous
syn keyword   solConditional      if else 
syn keyword   solRepeat           while for do
syn keyword   solLabel            case break continue 
syn keyword   solException        try catch throw

hi def link   solConditional      Conditional
hi def link   solRepeat           Repeat
hi def link   solLabel            Label
hi def link   solException        Exception

syn keyword   solStorageType      storage memory calldata payable
hi def link   solStorageType      StorageClass


syn keyword   testConstant        constant
syn keyword   testIdentifier      identifier
syn keyword   testStatement       statement
syn keyword   testPreProc         preproc
syn keyword   testType            type
syn keyword   testSpecial         special
syn keyword   testUnderlined      underlined
syn keyword   testIgnore          ignore
syn keyword   testError           error
syn keyword   testTodo            todo

hi def link   testConstant        Constant
hi def link   testIdentifier      Identifier
hi def link   testStatement       Statement
hi def link   testPreProc         PreProc
hi def link   testType            Type
hi def link   testSpecial         Special
hi def link   testUnderlined      Underlined
hi def link   testIngore          Ignore
hi def link   testError           Error
hi def link   testTodo            Todo
