" Vim syntax file
" Language:     Solidity
" Maintainer:   TovarishFin (tovarishFin@gmail.com)
" URL:          https://github.com/TovarishFin/vim-solidity

if exists("b:current_syntax")
  finish
endif

"Keywords
syn keyword   solKeyword           abstract anonymous as assembly break case catch constant continue default
syn keyword   solKeyword           delete do else emit enum external final for if import in indexed inline
syn keyword   solKeyword           interface internal is let match memory modifier new of payable pragma private public pure
syn keyword   solKeyword           relocatable require return returns static storage struct throw try type typeof using
syn keyword   solKeyword           var view while calldata

hi def link   solKeyword           Keyword

syn keyword   solConstant          true false wei szabo finney ether seconds minutes hours days weeks years now
syn keyword   solConstant          block msg now tx sha3 keccak256 sha256 ripemd160 ecerecover addmod mulmod this super selfdestruct

hi def link   solConstant          Constant

"Types
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

"Comments
syn keyword   solTodo             TODO FIXME XXX TBD contained
syn region    solComment          start=/\/\// end=/$/ contains=solTodo
syn region    solComment          start=/\/\*/ end=/\*\// contains=solTodo

hi def link   solTodo             Todo
hi def link   solComment          Comment

"Natspec
syn match     solNatspecTag       /@dev\>/ contained
syn match     solNatspecTag       /@title\>/ contained
syn match     solNatspecTag       /@author\>/ contained
syn match     solNatspecTag       /@notice\>/ contained
syn match     solNatspecTag       /@param\>/ contained nextgroup=solNatspecParam skipwhite
syn match     solNatspecTag       /@return\>/ contained
"TODO: make solNatspecParam display as a different color
syn region    solNatspecTag       start=/@param\>\s/ end=/\s/ contained contains=solNatspecParam
syn region    solNatspecBlock     start=/\/\/\// end=/$/ contains=solTodo,solNatspecTag
syn region    solNatspecBlock     start=/\/\*\{2}/ end=/\*\// contains=solTodo,solNatspecTag

hi def link   solNatspecTag       Constant
hi def link   solNatspecBlock     Comment
hi def link   solNatspecParam     Label
