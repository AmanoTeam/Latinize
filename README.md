Latinize is a library and CLI tool written in Nim, it's indeed to convert accents (diacritics) from strings to latin characters.

This is a port of the original [Latinize.js](https://github.com/dundalek/latinize) Node package.

#### Installation

Install using `nimble`:

```bash
nimble install --accept 'git://github.com/AmanoTeam/Latinize.git'
```

_**Note**: Latinize requires Nim 1.4.0 or higher._

#### Library usage

```nim
import latinize

const
  text: string = "ỆᶍǍᶆṔƚÉ áéíóúýčďěňřšťžů"
  result: string = translate(s = text)

assert result == "ExAmPlE aeiouycdenrstzu"
```

#### CLI tool usage

```
$ latinize --help
usage: latinize [-h] [-v] -t TEXT

Simple Nim library and CLI tool to
convert accents (diacritics) from
strings to latin characters.

optional arguments:
  -h, --help        show this help
                    message and exit
  -v, --version     show version number
                    and exit
  -t TEXT, --text TEXT
                    text you want to
                    latinize

When no text are supplied, default
action is to read from standard input.
```

#### Downloads

You can download prebuilt static binaries of the CLI tool for Android and Linux from the [GitHub releases](https://github.com/AmanoTeam/Latinize/releases) page.

#### Contributing

If you have discovered a bug in this library and know how to fix it, fork this repository and open a Pull Request.

#### Third party software

Latinize includes some third party software in its codebase. See them below:

- **Latinize.js**
  - Author: Jakub Dundalek
  - Repository: [dundalek/latinize](https://github.com/dundalek/latinize)
  - License: [BSD-2-Clause License](https://github.com/dundalek/latinize/blob/master/LICENSE)
