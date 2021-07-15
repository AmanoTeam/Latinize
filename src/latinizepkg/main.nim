import strformat
import parseopt

import ./core

const helpMessage: string = """
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
"""

const versionNumber: string = "0.1"

const repository: string = staticExec("git config --get remote.origin.url")
const commitHash: string = staticExec("git rev-parse --short HEAD")

const versionInfo: string = fmt"Latinize v{versionNumber} ({repository}@{commitHash})" &
    "\n" &
    fmt"Compiled for {hostOS} ({hostCPU}) using Nim {NimVersion}" &
    fmt"({CompileDate}, {CompileTime})" &
    "\n"

const longNoVal: seq[string] = @[
    "help",
    "version"
]

const shortNoVal: set[char] = {
    'h',
    'v',
}

var
    text, argument: string

proc signalHandler() {.noconv.} =
    stdout.write("\n")
    quit(0)

setControlCHook(signalHandler)

var parser = initOptParser(longNoVal = longNoVal, shortNoVal = shortNoVal)

while true:
    parser.next()

    case parser.kind
    of cmdEnd:
        break
    of cmdShortOption, cmdLongOption:
        case parser.key
        of "version", "v":
            stdout.write(versionInfo)
            quit(0)
        of "help", "h":
            stdout.write(helpMessage)
            quit(0)
        of "text":
            if parser.val == "":
                stderr.write("latinize: missing required value for argument: --text\n")
                quit(1)
            else:
                text = parser.val
        of "t":
            if parser.val == "":
                stderr.write("latinize: missing required value for argument: -t\n")
                quit(1)
            else:
                text = parser.val
        else:
            argument = if len(parser.key) > 1: fmt("--{parser.key}") else: fmt("-{parser.key}")
            stderr.write(fmt"latinize: unrecognized argument: {argument}" & "\n")
            quit(1)
    else:
        discard

if text == "":
    for stdinText in stdin.lines:
        stdout.write(translate(s = stdinText) & "\n")
else:
    stdout.write(translate(s = text) & "\n")
