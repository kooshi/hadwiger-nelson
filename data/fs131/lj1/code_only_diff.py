#!/usr/bin/env python3
"""FS131-LJ1 (FS131-LC1's through FS131-LU1, unchanged but this line): "docstrings only" in text — a Lean file with every block comment removed (`/- … -/`, nested; docstrings
`/-- … -/` and module docs `/-! … -/` are block comments) is the same at two states.

Usage: code_only_diff.py BASE_COMMIT FILE [FILE ...]        compare `git show BASE:FILE` with the working file
       code_only_diff.py BASE_COMMIT FILE [FILE ...] --plant  alter one code character of the working text in memory
                                                             (the first `:=` becomes `:≡`): every file must read DIFFERS
What is compared is every character outside block comments, runs of whitespace collapsed (a docstring's length moves
line breaks, nothing else).  Line comments (`-- …`) are code to this check: none is edited.  The statements as the
kernel stores them are the stronger check (statements/); this one also covers proofs and `example`s, which are not
stored.  Exit 0: every file SAME (or, with --plant, every file DIFFERS); 1 otherwise."""
import re, subprocess, sys

def strip(src):
    out, i, depth, n = [], 0, 0, len(src)
    while i < n:
        two = src[i:i + 2]
        if two == "/-":
            depth += 1; i += 2
        elif two == "-/" and depth:
            depth -= 1; i += 2
        else:
            if not depth:
                out.append(src[i])
            i += 1
    if depth:
        raise SystemExit("unbalanced block comment")
    return re.sub(r"\s+", " ", "".join(out)).strip()

args = [a for a in sys.argv[1:] if not a.startswith("--")]
plant = "--plant" in sys.argv
base, files, bad = args[0], args[1:], 0
for f in files:
    old = subprocess.run(["git", "show", f"{base}:{f}"], capture_output=True, text=True, check=True).stdout
    new = open(f, encoding="utf-8").read()
    if plant:
        new = new.replace(":=", ":≡", 1)
    a, b = strip(old), strip(new)
    same = a == b
    print(f"{'SAME   ' if same else 'DIFFERS'} {f}: {len(a)} characters of code at {base[:9]}, {len(b)} now; "
          f"comment characters {len(old) - len(a)} -> {len(new) - len(b)} (whitespace counted with them)")
    bad += (same if plant else not same)
print(("plant: " if plant else "") + ("OK" if not bad else f"FAIL ({bad})"))
sys.exit(1 if bad else 0)
