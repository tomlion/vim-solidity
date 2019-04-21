" Vim syntax file
" Language:     Solidity
" Maintainer:   TovarishFin (tovarishFin@gmail.com)
" URL:          https://github.com/TovarishFin/vim-solidity

if exists("b:current_syntax")
  finish
endif

" Constants
syn keyword   solConstant         true false wei szabo finney ether seconds minutes hours days weeks years now super 
syn keyword   solConstant         block msg now tx sha3 keccak256 sha256 ripemd160 ecerecover addmod mulmod this selfdestruct

hi def link   solConstant         Constant

" Keywords
syn keyword   solKeyword          abstract anonymous as assembly constant default
syn keyword   solKeyword          delete emit final import in indexed inline using
syn keyword   solKeyword          interface is let match modifier new of pragma typeof 
syn keyword   solKeyword          relocatable require return returns static type var 

hi def link   solKeyword          Keyword

syn keyword   solFuncModifier     external internal payable public pure view 

hi def link   solFuncModifier     Keyword


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

syn match     solOperator         /\(!\||\|&\|+\|-\|<\|>\|=\|%\|\/\|*\|\~\|\^\)/

hi def link   solOperator         Operator

syntax match  solNumber           /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>/
syntax match  solNumber           /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/
syntax region solString           start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+

hi def link   solNumber           Number
hi def link   solString           String

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

hi def link   solNatspecTag       Constant
hi def link   solNatspecBlock     Comment
hi def link   solNatspecParam     Label
