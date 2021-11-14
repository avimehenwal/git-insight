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
