#!/usr/bin/env python3
"""FS131-KN6 stage 1: every quotation of the brief against its source (standing rule 3).

A quotation in the brief is a line `> <text>` whose next line is `> — source: <path> …`.
The check is exact: `<text>` must be one whole line of the file at `<path>`, character
for character.

  --root DIR   the tree holding the brief and the sources (default: this tool's tree)
  --plant      change one character of every source line that matched, in memory, and
               require every quotation to be reported (the negative control)

Prints one line per quotation and a count line `quotations=<n> identical=<i> differing=<d>`.
Exit 0: every quotation identical and at least one found. Exit 1 otherwise.
"""
import pathlib
import sys

BRIEF = "data/fs131/briefs/FS131-KN6-chain-first-layer.md"


def quotations(text):
    lines = text.splitlines()
    out = []
    for i, line in enumerate(lines[:-1]):
        nxt = lines[i + 1]
        if line.startswith("> ") and nxt.startswith("> — source: "):
            path = nxt[len("> — source: "):].split()[0]
            out.append((line[2:], path))
    return out


def main():
    args = sys.argv[1:]
    plant = "--plant" in args
    root = pathlib.Path(__file__).resolve().parent.parent
    if "--root" in args:
        root = pathlib.Path(args[args.index("--root") + 1])
    quotes = quotations((root / BRIEF).read_text())
    same = diff = 0
    for text, path in quotes:
        src = (root / path).read_text().splitlines()
        if plant:
            # flip the last character of the matching line: the comparison must now fail
            src = [l[:-1] + ("#" if l[-1:] != "#" else "!") if l == text else l for l in src]
        head = text[:60].replace("\n", " ")
        if text in src:
            same += 1
            print(f"IDENTICAL  {path}  | {head}…")
        else:
            diff += 1
            print(f"DIFFERS    {path}  | {head}…")
    print(f"quotations={len(quotes)} identical={same} differing={diff}")
    return 0 if quotes and diff == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
