" Vim syntax file
" Language:     Solidity
" Maintainer:   TovarishFin (tovarishFin@gmail.com)
" URL:          https://github.com/TovarishFin/vim-solidity

if exists("b:current_syntax")
  finish
endif


" Types
syn match     solValueType        /\<uint\d*\>/
syn match     solValueType        /\<int\d*\>/
syn match     solValueType        /\<fixed\d*\>/
syn match     solValueType        /\<ufixed\d*\>/
syn match     solValueType        /\<bytes\d*\>/
syn match     solValueType        /\<address\>/
syn match     solValueType        /\<string\>/
syn match     solValueType        /\<bool\>/

hi def link   solValueType        Type

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
syn match     solFuncName         /\<[a-zA-Z_$][0-9a-zA-z_$]*/ contained nextgroup=solFuncParam skipwhite
syn region    solFuncParam        matchgroup=solParens start='(' end=')' contained contains=solFuncComma,solValueType,solStorageType nextgroup=solFuncModCustom,solFuncReturn keepend skipempty skipwhite
syn match     solFuncComma        ',' contained
syn keyword   solFuncModifier     external internal payable public pure view 
syn match     solFuncModCustom    /\<[a-zA-Z_$][0-9a-zA-z_$]*/ contained nextgroup=solFuncParam,solFuncModCustom skipempty skipwhite 
syn region    solFuncReturn       matchgroup=solParens start='(' end=')' contained contains=solFuncComma,solValueType,solStorageType


hi def link   solFunction         Type
hi def link   solConstructor      Type
hi def link   solFuncName         Function
hi def link   solFuncComma        Delimiter
hi def link   solFuncModifier     Keyword
hi def link   solFuncModCustom    Keyword
hi def link   solParens           Delimiter

" Modifiers
syn keyword   solModifier         modifier nextgroup=solModifiername skipwhite
syn match     solModifierName     /\<[a-zA-Z_$][0-9a-zA-z_$]*/ contained nextgroup=solModifierParam skipwhite
syn region    solModifierParam    matchgroup=solParens start='(' end=')' contained contains=solModifierComma,solValueType,solStorageType nextgroup=solModifierBody skipwhite skipempty 
syn region    solModifierBody     start='{' end='}' contained contains=solModifierInsert,solValueType,solConstant,solKeyword,solConditional,solRepeat,solLabel,solException,solStructure,solStorageType,solOperator,solNumber,solString skipempty skipwhite keepend transparent
syn match     solModifierComma    ',' contained
syn match     solModifierInsert   /\<_\>/ contained 

hi def link   solModifier         Type
hi def link   solModifierName     Function
hi def link   solModifierComma    Delimiter
hi def link   solModifierInsert   Function

" Contracts, Librares, Interfaces
syn match     solContract         /\<\%(contract\|library\|interface\)\>/ nextgroup=solContractName skipwhite
syn match     solContractName     /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ contained nextgroup=solContractParent skipwhite
syn region    solContractParent   start='is' end='{' contains=solContractName,solContractComma,solInheritor
syn match     solContractComma    ','
syn match     solInheritor        'is' contained

hi def link   solContract         Type
hi def link   solContractName     Function
hi def link   solContractComma    Delimiter
hi def link   solInheritor        Keyword

" Events
syn match     solEvent            'event' nextgroup=solEventName,solEventParams skipwhite
syn match     solEventName        /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=solEventParam contained skipwhite
syn region    solEventParam       matchgroup=solParens start='(' end=')' contains=solEventParamComma,solValueType,solEventParamMod,other contained skipwhite skipempty
syn match     solEventParamComma  ',' contained
syn match     solEventParamMod    /indexed/ contained

hi def link   solEvent            Type
hi def link   solEventName        Function
hi def link   solEventParamMod    Keyword
hi def link   solEventParamComma  Delimiter

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
syn match     solNatspecTag       /@param\>/ contained nextgroup=solNatspecParam skipwhite
syn match     solNatspecTag       /@return\>/ contained
" TODO: make solNatspecParam display as a different color
syn region    solNatspecTag       start=/@param\>\s/ end=/\s/ contained contains=solNatspecParam
syn region    solNatspecBlock     start=/\/\/\// end=/$/ contains=solTodo,solNatspecTag
syn region    solNatspecBlock     start=/\/\*\{2}/ end=/\*\// contains=solTodo,solNatspecTag

hi def link   solNatspecTag       SpecialComment
hi def link   solNatspecBlock     Comment
hi def link   solNatspecParam     Label


" Constants
syn keyword   solConstant         true false wei szabo finney ether seconds minutes hours days weeks years now super 
syn keyword   solConstant         block msg now tx sha3 keccak256 sha256 ripemd160 ecerecover addmod mulmod this selfdestruct

hi def link   solConstant         Constant

" Keywords
syn keyword   solKeyword          abstract anonymous as assembly constant default
syn keyword   solKeyword          delete emit final import in inline using
syn keyword   solKeyword          interface let match new of pragma typeof 
syn keyword   solKeyword          relocatable require return returns static type var 

hi def link   solKeyword          Keyword

"Miscellaneous
syn keyword   solConditional      if else 
syn keyword   solRepeat           while for do
syn keyword   solLabel            case break continue 
syn keyword   solException        try catch throw

hi def link   solConditional      Conditional
hi def link   solRepeat           Repeat
hi def link   solLabel            Label
hi def link   solException        Exception

syn keyword   solStorageType      storage memory calldata
syn keyword   solStructure        struct enum mapping

hi def link   solStorageType      StorageClass
hi def link   solStructure        Structure
