" Vim syntax file
" Language:     Solidity
" Maintainer:   TovarishFin (tovarishFin@gmail.com)
" URL:          https://github.com/TovarishFin/vim-solidity

if exists("b:current_syntax")
  finish
endif

syn sync minlines=50

" Common Groups
syn match     solComma            ','
syn keyword   solStorageType      contained skipempty skipwhite nextgroup=solStorageType,solStorageConst
      \ public private internal
syn keyword   solStorageConst     contained skipempty skipwhite nextgroup=solStorageType
      \ constant
syn keyword   solFuncStorageType  contained
      \ storage calldata memory
syn keyword   solFuncPayableType  contained
      \ payable

hi def link   solStorageType      Keyword
hi def link   solFuncStorageType  Keyword
hi def link   solStorageConst     Keyword

" Common Groups Highlighting
hi def link   solParens           Normal
hi def link   solComma            Normal

" Complex Types
syn keyword   solMapping          skipempty skipwhite nextgroup=solMappingParens
      \ mapping
syn region    solMappingParens    start='(' end=')' contained contains=solValueType,solMapping nextgroup=solStorageType,solStorageConst skipempty skipwhite
syn keyword   solEnum             nextgroup=solEnumBody skipwhite skipempty
      \ enum
syn region    solEnumBody         start='(' end=')' contained contains=solComma,solValueType
syn keyword   solStruct           nextgroup=solStructBody skipempty skipwhite
      \ struct
syn region    solStructBody       start='{' end='}' contained contains=solComma,solValueType,solStruct,solEnum,solMapping
syn match     solCustomType       skipempty skipwhite nextgroup=solStorageType,solStorageConst
      \ '\v[a-zA-Z_][a-zA-Z0-9_]*\s*(<public>|<private>|<internal>|<constant>)@='

hi def link   solMapping          Define
hi def link   solEnum             Define
hi def link   solStruct           Define

" Numbers
syntax match  solNumber           '\v0x\x+>'
syntax match  solNumber           '\v\c<%(\d+%(e[+-]=\d+)=|0b[01]+|0o\o+|0x\x+)>'
syntax match solNumber            '\v\c<%(\d+.\d+|\d+.|.d+)%(e[+-]=\d+)=>'

" Strings
syntax region solString           start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region solString           start="\v'" skip="\v\\." end="\v'"

hi def link   solNumber           Number
hi def link   solString           String

" Operators
syn match     solOperator         '\v\!'
syn match     solOperator         '\v\|'
syn match     solOperator         '\v\&'
syn match     solOperator         '\v\%'
syn match     solOperator         '\v\~'
syn match     solOperator         '\v\^'
syn match     solOperator         '\v\*'
syn match     solOperator         '\v/'
syn match     solOperator         '\v\+'
syn match     solOperator         '\v-'
syn match     solOperator         '\v\?'
syn match     solOperator         '\v\>'
syn match     solOperator         '\v\<'
syn match     solOperator         '\v\>\='
syn match     solOperator         '\v\<\='
syn match     solOperator         '\v\='
syn match     solOperator         '\v\*\='
syn match     solOperator         '\v/\='
syn match     solOperator         '\v\+\='
syn match     solOperator         '\v-\='

hi def link   solOperator         Operator

" Destructuring TODO: make in multiline...
syn region    solDestructure      contained contains=solValueType,solComma,solFuncStorageType
      \ start='\(\S\)\@<!(\s*\(uint\|int\|ufixed\|bytes\|address\|string\|bool\)\@='
      \ end=')\s*\ze='

hi def link   solDestructure      Keyword

" Functions
syn keyword   solConstructor      nextgroup=solFuncParam skipwhite skipempty
      \ constructor
syn keyword   solFunction         nextgroup=solFuncName,solFuncParam skipwhite skipempty
      \ function
syn match     solFuncName         contained nextgroup=solFuncParam skipwhite skipempty
      \ '\v<[a-zA-Z_][0-9a-zA-z_]*'
syn region    solFuncParam
      \ contained
      \ contains=solComma,solValueType,solFuncStorageType
      \ nextgroup=solFuncModCustom,solFuncModifier,solFuncReturn,solFuncBody
      \ skipempty
      \ skipwhite
      \ start='('
      \ end=')'

syn keyword   solFuncModifier     contained nextgroup=solFuncModifier,solFuncModCustom,solFuncReturn,solFuncBody skipwhite skipempty
      \ external internal payable public pure view private constant
syn match     solFuncModCustom    contained nextgroup=solFuncModifier,solFuncModCustom,solFuncReturn,solFuncBody,solFuncModParens  skipempty skipwhite
      \ '\v<[a-zA-Z_][0-9a-zA-z_]*'
syn keyword   solFuncReturn       contained nextgroup=solFuncRetParens skipwhite skipempty returns
syn region    solFuncRetParens    contains=solValueType,solFuncStorageType nextgroup=solFuncBody skipempty skipwhite
      \ start='(' 
      \ end=')' 
syn region    solFuncBody         contained fold transparent contains=solDestructure,solComment,solAssemblyBlock,solEmitEvent,solTypeCast,solMethod,solValueType,solConstant,solKeyword,solRepeat,solLabel,solException,solStructure,solFuncStorageType,solOperator,solNumber,solString,solFuncCall,solIf,solLoop skipempty skipwhite
      \ start='{' 
      \ end='}' 
syn match     solFuncCall         contained skipempty skipwhite nextgroup=solFuncCallParens
      \ '\v(<if>|<uint>|<int>|<ufixed>|<bytes>|<address>|<string>|<bool>)@<!<[a-zA-Z_][0-9a-zA-z_]*\s*(\((\n|.|\s)*\))@='
syn region    solFuncCallParens   contained transparent
      \ start='('
      \ end=')'
syn region    solFuncModParens    contained contains=solConstant nextgroup=solFuncReturn,solFuncModifier,solFuncModCustom,solFuncBody skipempty skipwhite transparent
      \ start='('
      \ end=')'

hi def link   solFunction         Define
hi def link   solConstructor      Define
hi def link   solFuncName         Function
hi def link   solFuncModifier     Keyword
hi def link   solFuncModCustom    Keyword
hi def link   solFuncCall         Function
hi def link   solFuncReturn       special

" Modifiers
syn keyword   solModifier         modifier nextgroup=solModifiername skipwhite
syn match     solModifierName     /\<[a-zA-Z_][0-9a-zA-z_]*/ contained nextgroup=solModifierParam skipwhite
syn region    solModifierParam    start='(' end=')' contained contains=solComma,solValueType,solFuncStorageType nextgroup=solModifierBody skipwhite skipempty
syn region    solModifierBody     start='{' end='}' contained contains=solDestructure,solAssemblyBlock,solEmitEvent,solTypeCast,solMethod,solFuncCall,solModifierInsert,solValueType,solConstant,solKeyword,solRepeat,solLabel,solException,solStructure,solFuncStorageType,solOperator,solNumber,solString,solFuncCall,solIf,solLoop skipempty skipwhite transparent
syn match     solModifierInsert   /\<_\>/ containedin=solModifierBody

hi def link   solModifier         Define
hi def link   solModifierName     Function
hi def link   solModifierInsert   Function

" Contracts, Librares, Interfaces
syn match     solContract         /\<\%(contract\|library\|interface\)\>/ nextgroup=solContractName skipwhite
syn match     solContractName     /\<[a-zA-Z_][0-9a-zA-Z_]*/ contained nextgroup=solContractParent skipwhite
syn region    solContractParent   start=/\<is\>/ end='{' contained contains=solContractName,solComma,solInheritor
syn match     solInheritor        /\<is\>/ contained
syn region    solLibUsing         start=/\<using\>/ end=/\<for\>/ contains=solLibName
syn match     solLibName          /[a-zA-Z_][0-9a-zA-Z_]*\s*\zefor/ contained

hi def link   solContract         Define
hi def link   solContractName     Function
hi def link   solInheritor        Keyword
hi def link   solLibUsing         Special
hi def link   solLibName          Type

" Events
syn match     solEvent            /\<event\>/ nextgroup=solEventName,solEventParams skipwhite
syn match     solEventName        /\<[a-zA-Z_][0-9a-zA-Z_]*/ nextgroup=solEventParam contained skipwhite
syn region    solEventParam       start='(' end=')' contains=solComma,solValueType,solEventParamMod,other contained skipwhite skipempty
syn match     solEventParamMod    /\(\<indexed\>\|\<anonymous\>\)/ contained
syn keyword   solEmitEvent        emit

hi def link   solEvent            Define
hi def link   solEventName        Function
hi def link   solEventParamMod    Keyword
hi def link   solEmitEvent        Special

" Constants
syn keyword   solConstant         true false wei szabo finney ether seconds minutes hours days weeks years now super
syn keyword   solConstant         block msg now tx this abi

hi def link   solConstant         Constant

" Reserved keywords https://solidity.readthedocs.io/en/v0.5.7/miscellaneous.html#reserved-keywords
syn keyword   solReserved         abstract after alias apply auto case catch copyof default
syn keyword   solReserved         define final immutable implements in inline let macro match
syn keyword   solReserved         mutable null of override partial promise reference relocatable
syn keyword   solReserved         sealed sizeof static supports switch try typedef typeof unchecked

hi def link   solReserved         Error

" Pragma
syn match     solPragma           /\<pragma\s*solidity\>/

hi def link   solPragma           PreProc

" Assembly
syn keyword   solAssemblyName     assembly  contained
syn region    solAssemblyBlock    start=/\<assembly\s*{/ end=/}/ contained contains=solAssemblyName,solAssemblyLet,solAssemblyOperator,solAssemblyConst,solAssemblyMethod,solComment,solNumber,solString,solOperator,solAssemblyCond,solAssmNestedBlock
syn match     solAssemblyOperator /\(:=\)/ contained
syn keyword   solAssemblyLet      let contained
syn keyword   solAssemblyMethod   stop add sub mul div sdiv mod smod exp not lt gt slt sgt eq iszero contained
syn keyword   solAssemblyMethod   and or xor byte shl shr sar addmod mulmod signextend keccak256 jump contained
syn keyword   solAssemblyMethod   jumpi pop mload mstore mstore8 sload sstore calldataload calldatacopy contained
syn keyword   solAssemblyMethod   codecopy extcodesize extcodecopy returndatacopy extcodehash create create2 contained
syn keyword   solAssemblyMethod   call callcode delegatecall staticcall return revert selfdestruct contained
syn keyword   solAssemblyMethod   log0 log1 log2 log3 log4 blockhash contained
syn match     solAssemblyMethod   /\<\(swap\|dup\)\d\>/ contained
syn keyword   solAssemblyConst    pc msize gas address caller callvalue calldatasize codesize contained
syn keyword   solAssemblyConst    returndatasize origin gasprice coinbase timestamp number difficulty gaslimit contained
syn keyword   solAssemblyCond     if else contained
syn region    solAssmNestedBlock  start=/\(assembly\s*\)\@<!{/ end=/}/ contained skipwhite skipempty transparent

hi def link   solAssemblyBlock    PreProc
hi def link   solAssemblyName     Special
hi def link   solAssemblyOperator Operator
hi def link   solAssemblyLet      Keyword
hi def link   solAssemblyMethod   Special
hi def link   solAssemblyConst    Constant
hi def link   solAssemblyCond     Conditional

" Builtin Methods
syn keyword   solMethod           delete new var return import
syn region    solMethodParens     start='(' end=')' contained transparent
syn keyword   solMethod           nextgroup=solMethodParens skipwhite skipempty
      \ blockhash require revert assert keccak256 sha256
      \ ripemd160 ecrecover addmod mullmod selfdestruct

hi def link   solMethod           Special

" Miscellaneous
syn keyword   solRepeat           do
syn keyword   solLabel            break continue
syn keyword   solException        throw

hi def link   solRepeat           Repeat
hi def link   solLabel            Label
hi def link   solException        Exception

" Simple Types
syn match     solValueType        /\<uint\d*\>/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<int\d*\>/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<fixed\d*\>/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<ufixed\d*\>/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<bytes\d*\>/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<address\>/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<string\>/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<bool\>/ nextgroup=solStorageType,solStorageConst skipwhite skipempty

syn match     solValueType        /\<uint\d*\[\]/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<int\d*\[\]/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<fixed\d*\[\]/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<ufixed\d*\[\]/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<bytes\d*\[\]/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<address\[\]/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /\<string\[\]/ nextgroup=solStorageType,solStorageConst skipwhite skipempty
syn match     solValueType        /bool\[\]/ nextgroup=solStorageType,solStorageConst skipwhite skipempty

syn match     solTypeCast         /\<uint\d*\ze\s*(/ nextgroup=solTypeCastParens skipwhite skipempty
syn match     solTypeCast         /\<int\d*\ze\s*(/ nextgroup=solTypeCastParens skipwhite skipempty
syn match     solTypeCast         /\<ufixed\d*\ze\s*(/ nextgroup=solTypeCastParens skipwhite skipempty
syn match     solTypeCast         /\<bytes\*\ze\s*(/ nextgroup=solTypeCastParens skipwhite skipempty
syn match     solTypeCast         /\<address\ze\s*(/ nextgroup=solTypeCastParens skipwhite skipempty
syn match     solTypeCast         /\<string\ze\s*(/ nextgroup=solTypeCastParens skipwhite skipempty
syn match     solTypeCast         /\<bool\ze\s*(/ nextgroup=solTypeCastParens skipwhite skipempty
syn region    solTypeCastParens   start=/(/ end=/)/ contained transparent

hi def link   solValueType        Type
hi def link   solTypeCast         Type

" Conditionals
syn match     solIf               /\<if\>/ contained skipwhite skipempty nextgroup=solIfParens
syn match     solElse             /\<else\>/ contained skipwhite skipempty nextgroup=solIf,solIfBlock
syn region    solIfParens         start=/(/ end=/)/ contained nextgroup=solIfBlock skipwhite skipempty transparent
syn region    solIfBlock          start=/{/ end=/}/ contained nextgroup=solElse skipwhite skipempty transparent

hi def link   solIf               Keyword
hi def link   solElse             Keyword

" Loops
syn match     solLoop             /\(\<for\>\|\<while\>\)/ contained skipwhite skipempty nextgroup=solIfParens
syn region    solLoopParens       start=/(/ end=/)/ contained nextgroup=solLoopBlock skipwhite skipempty transparent
syn region    solLoopBlock        start=/{/ end=/}/ contained skipwhite skipempty transparent

hi def link   solLoop             Keyword


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
