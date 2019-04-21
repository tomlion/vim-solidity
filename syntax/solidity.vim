" Vim syntax file
" Language:     Solidity
" Maintainer:   TovarishFin (tovarishFin@gmail.com)
" URL:          https://github.com/TovarishFin/vim-solidity

if exists("b:current_syntax")
  finish
endif

"Types

syn match     solValueType    /\<uint\d*\>/
syn match     solValueType    /\<int\d*\>/
syn match     solValueType    /\<fixed\d*\>/
syn match     solValueType    /\<ufixed\d*\>/
syn match     solValueType    /\<bytes\d*\>/
syn match     solValueType    /\<address\>/
syn match     solValueType    /\<string\>/
syn match     solValueType    /\<bool\>/

hi def link   solValueType    Type

"Comments
syn keyword   solTodo         TODO FIXME XXX TBD contained
syn region    solComment      start=/\/\// end=/$/ contains=solTodo
syn region    solComment      start=/\/\*/ end=/\*\// contains=solTodo

hi def link   solTodo         Todo
hi def link   solComment      Comment

"Natspec
syn match     solNatspecTag   /@dev\>/ contained
syn match     solNatspecTag   /@title\>/ contained
syn match     solNatspecTag   /@author\>/ contained
syn match     solNatspecTag   /@notice\>/ contained
syn match     solNatspecTag   /@param\>/ contained nextgroup=solNatspecParam skipwhite
syn match     solNatspecTag   /@return\>/ contained
"TODO: make solNatspecParam display as a different color
syn region    solNatspecTag   start=/@param\>\s/ end=/\s/ contained contains=solNatspecParam

syn region    solNatspecBlock start=/\/\/\// end=/$/ contains=solTodo,solNatspecTag
syn region    solNatspecBlock start=/\/\*\{2}/ end=/\*\// contains=solTodo,solNatspecTag

hi def link   solNatspecTag   Constant
hi def link   solNatspecBlock Comment
hi def link   solNatspecParam Label

