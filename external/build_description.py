import argparse
import io

parser = argparse.ArgumentParser(
    prog="latinize",
    description="Simple Nim library and CLI tool to convert accents (diacritics) from strings to latin characters.",
    allow_abbrev=False,
    epilog="When no text are supplied, default action is to read from standard input."
)

parser.add_argument(
	"-v",
    "--version",
    action="store_true",
    help="show version number and exit"
)

parser.add_argument(
	"-t",
    "--text",
	required=True,
    help="text you want to latinize"
)

print("Saving to ./cmd.txt")

with open(file="./cmd.txt", mode="w") as file:
	parser.print_help(file=file)