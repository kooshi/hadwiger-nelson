#!/usr/bin/env python3
"""FS116-Z1 working tool: print the raw text of every derivation block of a record (header to blank line); controls with -c."""
import sys, re
path = sys.argv[1]; withc = "-c" in sys.argv
lines = open(path, encoding="utf-8").read().split("\n")
i = 0; infence = False
while i < len(lines):
    l = lines[i]
    if l.startswith("```"): infence = not infence
    m = re.match(r"^(derivation|control):\s", l)
    if m and not infence and (m.group(1) == "derivation" or withc):
        j = i
        while j < len(lines) and lines[j].strip() != "": j += 1
        print("\n".join(lines[i:j])); print(); i = j
    else: i += 1
