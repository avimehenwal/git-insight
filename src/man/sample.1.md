% HELLO(1) Version 1.0 | Frivolous "Hello World" Documentation

# NAME

**hello** — prints Hello, World!

# SYNOPSIS

| **hello** \[**-o**|**--out** _file_] \[_dedication_]
| **hello** \[**-h**|**--help**|**-v**|**--version**]

# DESCRIPTION

Prints "Hello, _dedication_!" to the terminal. If no dedication is
given, uses the default dedication. The default dedication is chosen by
the following sequence:

1.  Using the environment variable _DEFAULT_HELLO_DEDICATION_
2.  Using the per-user configuration file, _~/.hellorc_
3.  Using the system-wide configuration file, _/etc/hello.conf_
4.  Finally, using "world".

## Options

-h, --help

: Prints brief usage information.

-o, --output

: Outputs the greeting to the given filename.

    The file must be an **open(2)**able and **write(2)**able file.

-v, --version

: Prints the current version number.

# FILES

_~/.hellorc_

: Per-user default dedication file.

_/etc/hello.conf_

: Global default dedication file.

# ENVIRONMENT

**DEFAULT_HELLO_DEDICATION**

: The default dedication if none is given. Has the highest precedence
if a dedication is not supplied on the command line.

# BUGS

See GitHub Issues: <https://github.com/[owner]/[repo]/issues>

# AUTHOR

Foobar Goodprogrammer <foo@example.org>

# SEE ALSO

**hi(1)**, **hello(3)**, **hello.conf(4)**
