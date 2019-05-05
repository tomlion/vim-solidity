# vim-solidity
Syntax files for [Solidity](https://github.com/ethereum/solidity), the
contract-oriented programming language for Ethereum.

This repo has been forked from [tomlion's repo](https://github.com/tomlion/vim-solidity). It seems that the repository has been abandoned so I figured I would pick it up and improve my regex game :)

I intend to use this tool daily, so expect updates! PRs are also welcome.

## Improvements over the old repo:
* assembly syntax highlighting
* natspec syntax
* more extensive color scheme
* scientific number notation (1e18 used much anyone?)
* constructor keyword highlighting
* calldata highlighting
* typecase highlighting
* abi keyword added
* anonymous & indexed event modifiers includes
* reserved words give errors
* overall more extensive and detailed syntax highlighting
* various bug fixes

## Before and After Example (old on left new on right)
![vim-solidity before & after](https://imgur.com/CXucXEh)

## Installation

**Important:** If you are using `vim-polyglot` make sure to disable the default syntax provider for solidity:
```
let g:polyglot_disabled = ['solidity']
```

If you do not do this, you will be using a combination of the old tomlion repo and this new repo. You will get some strange syntax...

### Pathogen
Run the following command:

```bash
git clone https://github.com/TovarishFin/vim-solidity.git ~/.vim/bundle/vim-solidity
```

### Vundle
Add the following line to your `~/.vimrc`:

```vim
Plugin 'TovarishFin/vim-solidity'
```

### Plug
Add the following line to your `~/.vimrc`:

```vim
Plug 'TovarishFin/vim-solidity'
```

### No Plugin Manager
Copy all of the files manually into your `~/.vim`.
