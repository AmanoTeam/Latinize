# Package

version = "0.1"
author = "SnwMds"
description  = "Simple Nim library to convert accents (diacritics) from strings to latin characters."
license = "LGPL-3.0"
srcDir = "src"
namedBin["latinizepkg/main"] = "latinize"
installExt = @["nim"]

# Dependencies

requires "nim >= 1.2.0"

task test, "Runs the test suite":
  exec "nim compile --run tests/tests.nim"
