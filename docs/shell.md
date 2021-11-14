# SHELL Scripting

## Bash

[GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/html_node/index.html#SEC_Contents)

- [shell expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)
- [terminal colors using tput](https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x405.html)

```
for i in {1..16}
do
        echo "$(tput setab ${i})Hello, world$(tput sgr0)"
        echo "$(tput setaf ${i})Hello, world$(tput sgr0)"
done
echo "$(tput bold)Hello, world$(tput sgr0)"
echo "$(tput dim)Hello, world$(tput sgr0)"
echo "$(tput smul)Hello, world$(tput sgr0)"
echo "$(tput rmul)Hello, world$(tput sgr0)"
echo "$(tput rev)Hello, world$(tput sgr0)"
echo "$(tput smso)Hello, world$(tput sgr0)"
echo "$(tput rmso)Hello, world$(tput sgr0)"
echo "$(tput blink)Title of the Program$(tput sgr0)"
```

## character encoding

what is see is different from how computer stores it.

Technically, ANSI should be the same as US-ASCII. It refers to the ANSI X3.4 standard, which is simply the ANSI organisation's ratified version of ASCII. Use of the top-bit-set characters is not defined in ASCII/ANSI as it is a 7-bit character set.

## Command Completions

- Is bash completion different from zsh completion?

Zsh Completion with Homebrew: This works exactly the same as bash completion. brew install zsh-completions.

### BASH

complete -W "list of arguments as words" COMMAND

#### from a completion function

compgen

https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial

### load completions from bash --> zsh

```
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source /path/to/your/bash_completion_script
```

Bash has awesome in built auto completion support but the bash autocomplete scripts don't work directly zsh as zsh environment doesn't have the essential bash autocomplete helper functions like compgen, complete. It does so in an effort to keep zsh session fast.

These days zsh is shipped with appropriate completion scripts like compinit and bashcompinit which have the required functions to support bash autocomplete scripts.

autoload <func_name>: Note that autoload is defined in zsh and not bash. autoload looks for a file named in the directory paths returned by fpath command and marks a function to load the same when it is first invoked.

    -U: Ignore any aliases when loading a function like compinit or bashcompinit
    +X: Just load the named function fow now and don't execute it

https://stackoverflow.com/a/27853970/1915935

##### How to test autoloading functions

```
echo ${functions[calendar]}
calendar
echo ${functions[calendar]}
```

## ZSH

- Autoloading functions `autoload` builtin (or `functions -u` or `typeset -fu`)
- List all functions that shell knows about, `functions` (including Autoloading)
- `functions` is an associative array, use parameter expansion `${(k)functions}` to print all kV
- autoloading functions are marked as `::` in `functions` output `echo ${functions[spaceship::union]}`
- OPTIMIZATION: Thus including an element such as ‘/usr/local/funcs.zwc’ in fpath will speed up the search for functions, with the disadvantage that functions included must be explicitly recompiled by hand before the shell notices any changes.
- To load the definition of an autoloaded function myfunc without executing myfunc, use: `autoload +X myfunc`

```
unfunction myfunc
autoload myfunc
myfunc args

echo ${(kv)functions[myfunc]}

autoload +X myfunc
```

- Hook Functions `chpwd`, `periodic`, `precmd`, `preexec`, `zshaddhistory`, `zshexit`
- TRAP Functions
- add new path to fpath `fpath+=~/avimehenwal`
- ZSH Builtin commands
- `$` is a [Parameter in ZSH](https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters)
- If a `${...}` type parameter expression or a `$(...)` type command substitution

```
print -C3 {1..9}
print -l {1..9}
```

- Array manipulation
  - additions, deletions
  - traversal
  - slicing `${array[4,7]}`
  - element access `${array[-1]}`
  - element search

o | sorting
i,I | test if element is in array or not
u | remove repetitive
f | construct arrays from file
U, L | transform string to uppercase, lowercase
(M) | negate the pattern
:# | exclude search patern, like grep -v
t | print TYPE parameter expansion

```
print -l ${(M)fpath:#*avimehenwal*}

# get the type of parateter using parameter expansion
print -rl -- ${(t)fpath}
```

- Use calendar system provided by ZSH

## ZSH Completion

Zsh has two completion systems, an old, so called **compctl** completion (named after the builtin command that serves as its complete and only user interface), and a new one, referred to as **compsys**, organized as library of builtin and user-defined functions. The two systems differ in their interface for specifying the completion behavior. The new system is more customizable and is supplied with completions for many commonly used commands; it is therefore to be preferred.

1. compctl (old)
2. [compsys system](https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Completion-System) (new)

```
zle -C complete expand-or-complete completer
```

key-press-binding --> completion widget --> completion gen function

- Completion functions for commands are stored in files with names beginning with an underscore **\_,**
  - completion files are lazy loaded, should be in `fpath`
- The `_arguments`, `_describe` function is a wrapper around the `compadd` builtin function

### Resources

- [completion widgets](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Completion)
- [resource 1](https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org)
