" Vim syntax file
" Language:     Solidity
" Maintainer:   Tomlion (qycpublic@gmail.com)
" URL:          https://github.com/tomlion/vim-solidity

if exists("b:current_syntax")
  finish
endif

" basic
syn keyword solKeyword           anonymous as assembly break case catch constant continue contract default
syn keyword solKeyword           do else enum event external final for function if import indexed inline
syn keyword solKeyword           internal is let library match memory modifier new of private public
syn keyword solKeyword           relocatable return returns storage struct switch throw try type typeof using
syn keyword solKeyword           var while
syn keyword solConstant          true false wei szabo finney ether seconds minutes hours days weeks years now after
syn keyword solConstant          block msg now tx sha3 sha256 ripemd160 ecerecover addmod mulmod this super selfdestruct
syn keyword solBuiltinType       mapping address bool
syn keyword solBuiltinType       int int8 int16 int24 int32 int40 int48 int56 int64 int72 int80 int88 int96 int104 int112 int120 int128 int136 int144 int152 int160 int168 int178 int184 int192 int200 int208 int216 int224 int232 int240 int248 int256
syn keyword solBuiltinType       uint uint8 uint16 uint24 uint32 uint40 uint48 uint56 uint64 uint72 uint80 uint88 uint96 uint104 uint112 uint120 uint128 uint136 uint144 uint152 uint160 uint168 uint178 uint184 uint192 uint200 uint208 uint216 uint224 uint232 uint240 uint248 uint256
syn keyword solBuiltinType       fixed fixed8 fixed16 fixed24 fixed32 fixed40 fixed48 fixed56 fixed64 fixed72 fixed80 fixed88 fixed96 fixed104 fixed112 fixed120 fixed128 fixed136 fixed144 fixed152 fixed160 fixed168 fixed178 fixed184 fixed192 fixed200 fixed208 fixed216 fixed224 fixed232 fixed240 fixed248 fixed256
syn keyword solBuiltinType       ufixed ufixed8 ufixed16 ufixed24 ufixed32 ufixed40 ufixed48 ufixed56 ufixed64 ufixed72 ufixed80 ufixed88 ufixed96 ufixed104 ufixed112 ufixed120 ufixed128 ufixed136 ufixed144 ufixed152 ufixed160 ufixed168 ufixed178 ufixed184 ufixed192 ufixed200 ufixed208 ufixed216 ufixed224 ufixed232 ufixed240 ufixed248 ufixed256
syn keyword solBuiltinType       string string1 string2 string3 string4 string5 string6 string7 string8 string9 string10 string11 string12 string13 string14 string15 string16 string17 string18 string19 string20 string21 string22 string23 string24 string25 string26 string27 string28 string29 string30 string31 string32
syn keyword solBuiltinType       bytes bytes1 bytes2 bytes3 bytes4 bytes5 bytes6 bytes7 bytes8 bytes9 bytes10 bytes11 bytes12 bytes13 bytes14 bytes15 bytes16 bytes17 bytes18 bytes19 bytes20 bytes21 bytes22 bytes23 bytes24 bytes25 bytes26 bytes27 bytes28 bytes29 bytes30 bytes31 bytes32

hi def link solKeyword           Keyword
hi def link solConstant          Constant
hi def link solBuiltinType       Type

syn match   solOperator          /\(!\||\|&\|+\|-\|<\|>\|=\|%\|\/\|*\|\~\|\^\)/
syn match   solNumber            /\<-\=\d\+L\=\>\|\<0[xX]\x\+\>/
syn match   solFloat             /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
syn region  solString            start=+"+  skip=+\\\\\|\\$"+  end=+"+
syn region  solString            start=+'+  skip=+\\\\\|\\$'+  end=+'+

hi def link solOperator          Operator
hi def link solNumber            Number
hi def link solFloat             Float
hi def link solString            String

" Function
syn match   solFunction          /\<function\>/ nextgroup=solFuncName,solFuncArgs skipwhite
syn match   solFuncName          contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=solFuncArgs skipwhite
syn region  solFuncArgs          contained matchgroup=solFuncParens start='(' end=')' contains=solFuncArgCommas,solBuiltinType nextgroup=solModifierName,solFuncReturns keepend skipwhite skipempty
syn match   solModifierName      contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=solModifierArgs,solModifierName skipwhite
syn region  solModifierArgs      contained matchgroup=solFuncParens start='(' end=')' contains=solFuncArgCommas nextgroup=solModifierName,solFuncReturns skipwhite
syn region  solFuncReturns       contained matchgroup=solFuncParens start='(' end=')' contains=solFuncArgCommas,solBuiltinType
syn match   solFuncArgCommas     contained ','

hi def link solFunction          Type
hi def link solFuncName          Function
hi def link solModifierName      Function

" Contract
syn match   solContract          /\<\%(contract\|library\)\>/ nextgroup=solContractName skipwhite
syn match   solContractName      contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=solContractParent skipwhite
syn region  solContractParent    contained start='is' end='{' contains=solContractName,solContractNoise,solContractCommas skipwhite skipempty
syn match   solContractNoise     contained 'is' containedin=solContractParent
syn match   solContractCommas    contained ','

hi def link solContract          Type
hi def link solContractName      Function

" Event
syn match   solEvent             /\<event\>/ nextgroup=solEventName,solEventArgs skipwhite
syn match   solEventName         contained /\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=solEventArgs skipwhite
syn region  solEventArgs         contained matchgroup=solFuncParens start='(' end=')' contains=solEventArgCommas,solBuiltinType,solEventArgSpecial skipwhite skipempty
syn match   solEventArgCommas    contained ','
syn match   solEventArgSpecial   contained 'indexed'

hi def link solEvent             Type
hi def link solEventName         Function
hi def link solEventArgSpecial   Label

" Comment
syn keyword solCommentTodo       TODO FIXME XXX TBD contained
syn region  solLineComment       start=+\/\/+ end=+$+ contains=solCommentTodo,@Spell
syn region  solLineComment       start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ contains=solCommentTodo,@Spell fold
syn region  solComment           start="/\*"  end="\*/" contains=solCommentTodo,@Spell fold

hi def link solCommentTodo       Comment
hi def link solLineComment       Comment
hi def link solComment           Comment
